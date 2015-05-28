require "vigilion_rails_helper"

describe "ActiveRecord" do
  describe "#scan_file" do
    it "creates a store_attachment callback" do
      document = Document.new
      expect(document).to respond_to(:store_attachment!)
    end

    describe "store_attachment!" do
      it "routes to #index" do
        document = Document.new
        document.attachment = "https://www.relishapp.com/assets/relish-logo-visitor-b4a4aaae2adde2e82bf2152054152137.png"
        document.store_attachment!
      end
    end
  end
end