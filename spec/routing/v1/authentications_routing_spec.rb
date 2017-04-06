require "rails_helper"

RSpec.describe V1::AuthenticationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/v1/authentications").to route_to("v1/authentications#index")
    end

    it "routes to #new" do
      expect(:get => "/v1/authentications/new").to route_to("v1/authentications#new")
    end

    it "routes to #show" do
      expect(:get => "/v1/authentications/1").to route_to("v1/authentications#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/v1/authentications/1/edit").to route_to("v1/authentications#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/v1/authentications").to route_to("v1/authentications#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/authentications/1").to route_to("v1/authentications#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/authentications/1").to route_to("v1/authentications#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/authentications/1").to route_to("v1/authentications#destroy", :id => "1")
    end

  end
end
