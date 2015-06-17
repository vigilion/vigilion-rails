require "vigilion_rails_helper"

describe VigilionRails::CarrierwaveLocalFileIntegration do
  describe "#scan" do
    it "calls vigilion scanner" do
      document = CarrierwaveDocument.new
      expect(Vigilion).to receive(:scan_path)
      document.scan_attachment!
    end
  end
end