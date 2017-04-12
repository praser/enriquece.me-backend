require "rails_helper"

RSpec.describe V1::UsersController, :type => :routing do
  describe "routing" do
    let(:default_version) {"v1"}

    it "routes to #show" do
      expect(:get => "/user").to route_to(
        controller: "#{default_version}/users",
        action: "show",
        format: "json"
      )
    end

    it "routes to #create" do
      expect(:post => "/users").to route_to(
        controller: "#{default_version}/users",
        action: "create",
        format: "json"
      )
    end

    it "routes to #update" do
      expect(:put => "/user").to route_to(
        controller: "#{default_version}/users",
        action: "update",
        format: "json"
      )
    end

    it "routes to #destroy" do
      expect(:delete => "/user").to route_to(
        controller: "#{default_version}/users", 
        action: "destroy",
        format: "json"
      )
    end

  end
end