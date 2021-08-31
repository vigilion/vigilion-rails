module VigilionRails
  class VigilionScanJob < ApplicationJob
    queue_as :default

    def perform(integration_class, key, column)
      file = integration_class.constantize.find(key[:id])

      integration_class.constantize.new.scan key, file, column
    end
  end
end
