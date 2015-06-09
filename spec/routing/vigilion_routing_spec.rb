require "vigilion_rails_helper"

describe "VigilionController" do
  describe "routing" do
    it "routes to #index" do
      expect(post("/vigilion/callback")).to route_to("vigilion/vigilion#callback")
    end
  end
end