module VigilionRails
  class CarrierwaveLocalFileIntegration
    def scan(key, model, column)
      Vigilion.scan_path(key, model.send(column).path)
    end
  end
end
