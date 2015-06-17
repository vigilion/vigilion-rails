module VigilionRails
  class UrlIntegration
    def scan(key, model, column)
      Vigilion.scan_url(key, model.send(column).url)
    end
  end
end
