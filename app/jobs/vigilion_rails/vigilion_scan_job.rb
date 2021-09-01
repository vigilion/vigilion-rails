module VigilionRails
  class VigilionScanJob < ApplicationJob
    queue_as :default

    def perform(class_name, key, column)
      file = class_name.constantize.find(key[:id])

      VigilionRails::UrlIntegration.new.scan key, file, column
    end
  end
end
