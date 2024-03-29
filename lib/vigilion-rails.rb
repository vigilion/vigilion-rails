require "vigilion-rails/engine"
require "vigilion-rails/integrations/url_integration"
require "vigilion-rails/integrations/local_integration"
require "vigilion-rails/configuration"

module VigilionRails
  PENDING_STATUS = 'pending'

  module ActiveRecord
    def scan_file column, options={}
      default = { scan_column: "#{column}_scan_results", integration: Vigilion::Configuration.integration }
      options = default.merge(options)
      integration_class = "VigilionRails::#{options[:integration].to_s.camelize}Integration"
      class_eval <<-RUBY, __FILE__, __LINE__+1

        def scan_#{column}!
          key = { model: self.class.name, column: '#{column}', id: id }.to_json

          if Vigilion::Configuration.loopback
            logger.info 'vigilion scan request was simulated'

            self.class.find(id).on_scan_#{column} status: Vigilion::Configuration.loopback_response
          else
            if Vigilion::Configuration.active_job
              ::VigilionRails::VigilionScanJob.set(wait: 60).perform_later(#{integration_class}.to_s, self.class.name, id, key, '#{column}')
            else
              #{integration_class}.new.scan key, self, :#{column}
            end
            self.class.find(id).send('on_scan_#{column}', status: PENDING_STATUS)
          end
          @#{column}_old_url = #{column}.url
          return true
        end

        # Vigilion service callback
        def on_scan_#{column} params
          update_attribute('#{options[:scan_column]}', params[:status])
        end

        after_initialize :remember_#{column}_url
        after_commit :check_scan_#{column}, on: [:create, :update]

        def remember_#{column}_url
          @#{column}_old_url = #{column}.try(:url) unless new_record?
        end

        def check_scan_#{column}
          if @#{column}_old_url != #{column}.url
            scan_#{column}!
          end
        end

        def clean?
          #{options[:scan_column]} == "clean"
        end
      RUBY
    end
  end
end

ActiveRecord::Base.extend VigilionRails::ActiveRecord
