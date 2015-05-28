require "vigilion-rails/engine"

module VigilionRails

  module ActiveRecord
    def scan_file column, options={}
      default = { scan_column: "#{column}_scan_status" }
      options = default.merge(options)

      class_eval <<-RUBY, __FILE__, __LINE__+1

        # carrierwave callback
        def store_#{column}!
          #{options[:scan_column]} = 'pending'
          ::VirusScanner::File.scan_url('FIXTHIS', 'FIXTHIS')
        end
      RUBY
    end
  end
end

ActiveRecord::Base.extend VigilionRails::ActiveRecord
