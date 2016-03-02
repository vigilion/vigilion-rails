require "vigilion_rails_helper"

describe VigilionRails do
  describe "#clean?" do
    context "without scan results" do
      it "is not clean" do
        document = AgnosticDocument.new
        document.attachment_scan_results = nil
        expect(document).not_to be_clean
      end
    end

    context "with infected scan results" do
      it "is not clean" do
        document = AgnosticDocument.new
        document.attachment_scan_results = "infected"
        expect(document).not_to be_clean
      end
    end

    context "with clean scan results" do
      it "is clean" do
        document = AgnosticDocument.new
        document.attachment_scan_results = "clean"
        expect(document).to be_clean
      end
    end
  end

  describe "#scan_attachment!" do
    context "without loopback (normal behavior)" do
      disable_loopback

      it "calls vigilion scanner" do
        document = AgnosticDocument.new
        expect(Vigilion).to receive(:scan_url)
        document.scan_attachment!
      end
    end

    context "with loopback (local environments and tests)" do
      it "doesn't call vigilion scanner" do
        document = AgnosticDocument.create
        expect(Vigilion).not_to receive(:scan_url)
        document.scan_attachment!
      end

      # We want to simulate the real behavior so we don't provide
      # the scan results without reloading the model.
      # In a real scenario you also have to wait a random amount of
      # time.
      it "doesn't have scan results before reloading" do
        Vigilion::Configuration.loopback_response = "infected"
        document = AgnosticDocument.create
        document.scan_attachment!

        expect(document.attachment_scan_results).to eq nil
      end

      it "has scan results after reloading" do
        Vigilion::Configuration.loopback_response = "infected"
        document = AgnosticDocument.create
        document.scan_attachment!
        document.reload

        expect(document.attachment_scan_results).to eq "infected"
      end
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
    disable_loopback

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
