require "rails_helper"

RSpec.describe V1::CategoriesController, type: :routing do
  describe "routing" do
    let(:default_version) {"v1"}

    it "routes to #index" do
      expect(:get => "/categories").to route_to("#{default_version}/categories#index", format: "json")
    end

    it "routes to #show" do
      expect(:get => "/categories/1").to route_to("#{default_version}/categories#show", id: "1", format: "json")
    end

    it "routes to #create" do
      expect(:post => "/categories").to route_to("#{default_version}/categories#create", format: "json")
    end

    it "routes to #update via PUT" do
      expect(:put => "/categories/1").to route_to("#{default_version}/categories#update", id: "1", format: "json")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/categories/1").to route_to("#{default_version}/categories#update", id: "1", format: "json")
    end

    it "routes to #destroy" do
      expect(:delete => "/categories/1").to route_to("#{default_version}/categories#destroy", id: "1", format: "json")
    end

  end
end
