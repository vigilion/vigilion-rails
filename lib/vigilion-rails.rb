require "vigilion-rails/engine"

module VigilionRails

  module ActiveRecord
    def scan_file column, options={}
      default = { scan_column: "#{column}_scan_results" }
      options = default.merge(options)

      class_eval <<-RUBY, __FILE__, __LINE__+1

        @@vigilion_mappings ||= Hash.new
        @@vigilion_mappings['#{column}'] = '#{options[:scan_column]}'

        # carrierwave callback
        def store_#{column}!
          key = { model: self.class.name, column: '#{column}', id: id }.to_json
          Vigilion::File.scan_url(key, #{column})
        end
      RUBY
    end
  end
end

ActiveRecord::Base.extend VigilionRails::ActiveRecord
