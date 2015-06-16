require "vigilion_rails_helper"

describe VigilionRails do
  describe "#scan_attachment!" do
    it "calls vigilion scanner" do
      document = AgnosticDocument.new
      expect(Vigilion).to receive(:scan_url)
      document.scan_attachment!
    end
  end

  describe "#on_scan_attachment" do
    it "updates the scan column status" do
      document = AgnosticDocument.new
      document.on_scan_attachment status: "infected"
      expect(document.attachment_scan_results).to eq "infected"
    end
  end

  context "on save" do
    context "with a new instance" do
      let(:document){ AgnosticDocument.new(attachment_url: 'http://something') }

      it "calls vigilion scanner" do
        expect(Vigilion).to receive(:scan_url)
        document.save!
      end
    end

    context "with a different attachment.url" do
      it "calls vigilion scanner twice" do
        document = AgnosticDocument.new(attachment_url: 'http://something')
        expect(Vigilion).to receive(:scan_url).twice
        document.save!
        document.attachment_url = "http://different/url"
        document.save!
      end
    end

    context "with the same attachment.url" do
      it "calls vigilion scanner once" do
        document = AgnosticDocument.new(attachment_url: 'http://something')
        expect(Vigilion).to receive(:scan_url).once
        document.save!
        document.save!
      end

      context "saving and retrieving the record" do
        before do
          document = AgnosticDocument.new(attachment_url: 'http://something')
          expect(Vigilion).to receive(:scan_url).once
          document.save!
        end

        it "doesn't call vigilion scanner" do
          AgnosticDocument.last.save!
        end
      end
    end
  end
end