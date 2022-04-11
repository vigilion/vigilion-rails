require "vigilion_rails_helper"

describe VigilionRails::LocalIntegration do
  disable_loopback

  describe "#scan" do
    it "calls vigilion scanner" do
      document = CarrierwaveDocument.create
      expect(Vigilion).to receive(:scan_path)
      document.scan_attachment!
    end
  end
end
