require "vigilion-rails/engine"

module VigilionRails

  module ActiveRecord
    def scan_file column, options={}
      default = { scan_column: "#{column}_scan_results" }
      options = default.merge(options)

      class_eval <<-RUBY, __FILE__, __LINE__+1

        def scan_#{column}!
          key = { model: self.class.name, column: '#{column}', id: id }.to_json
          Vigilion::File.scan_url(key, #{column})
        end

        # Vigilion callback
        def on_scan_#{column} params
          update_attribute('#{options[:scan_column]}', params[:status])
        end

        # carrierwave callback
        alias_method :store_#{column}!, :scan_#{column}!
      RUBY
    end
  end
end

ActiveRecord::Base.extend VigilionRails::ActiveRecord
