module VigilionRails
  class VigilionScanJob < ApplicationJob
    queue_as :default

    def perform(integration_class, class_name, key, column)
      file = class_name.constantize.find(key[:id])

      integration_class.constantize.new.scan key, file, column
    end
  end
end
