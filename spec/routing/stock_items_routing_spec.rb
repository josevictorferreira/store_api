require "rails_helper"

RSpec.describe Api::V1::StockItemsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/stock_items").to route_to("api/v1/stock_items#index")
    end

    it "routes to #show" do
      expect(get: "/api/v1/stock_items/1").to route_to("api/v1/stock_items#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/api/v1/stock_items").to route_to("api/v1/stock_items#create")
    end

    it "routes to #add_items" do
      expect(put: "/api/v1/stock_items/1/add_items").to route_to("api/v1/stock_items#add_items", id: "1")
    end

    it "routes to #remove_items" do
      expect(put: "/api/v1/stock_items/1/remove_items").to route_to("api/v1/stock_items#remove_items", id: "1")
    end
  end
end
