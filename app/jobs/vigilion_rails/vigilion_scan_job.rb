module VigilionRails
  class VigilionScanJob < ApplicationJob
    queue_as :default

    def perform(integration_class, class_name, id, key, column)
      file = class_name.constantize.find(id)
      puts integration_class
      integration_class.new.scan key, file, column.to_sym
    end
  end
end
