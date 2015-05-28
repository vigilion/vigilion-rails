require "vigilion_rails_helper"

describe "VigilionController" do
  describe "routing" do
    it "routes to #index" do
      post("/vigilion/callback").should route_to("vigilion/vigilion#callback")
    end
  end
end