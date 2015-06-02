require "vigilion-rails/engine"

module VigilionRails

  module ActiveRecord
    def scan_file column, options={}
      default = { scan_column: "#{column}_scan_results" }
      options = default.merge(options)

      class_eval <<-RUBY, __FILE__, __LINE__+1

        def scan_#{column}!
          key = { model: self.class.name, column: '#{column}', id: id }.to_json
          Vigilion.scan_url(key, #{column}.url)
          return true
        end

        # Vigilion service callback
        def on_scan_#{column} params
          update_attribute('#{options[:scan_column]}', params[:status])
          @#{column}_old_url = #{column}.url
        end

        after_initialize :remember_#{column}_url
        after_save :check_scan_#{column}

        def remember_#{column}_url
          @#{column}_old_url = #{column}.url
        end

        def check_scan_#{column}
          if @#{column}_old_url != #{column}.url
            scan_#{column}!
          end
        end
      RUBY
    end
  end
end

ActiveRecord::Base.extend VigilionRails::ActiveRecord
