require "rails_helper"

RSpec.describe V1::UsersController, :type => :routing do
  describe "routing" do

    it "routes to #show" do
      expect(:get => "v1/user").to route_to(
        controller: "v1/users",
        action: "show",
        format: "json"
      )
    end

    it "routes to #create" do
      expect(:post => "v1/users").to route_to(
        controller: "v1/users",
        action: "create",
        format: "json"
      )
    end

    it "routes to #update" do
      expect(:put => "v1/user").to route_to(
        controller: "v1/users",
        action: "update",
        format: "json"
      )
    end

    it "routes to #destroy" do
      expect(:delete => "v1/user").to route_to(
        controller: "v1/users", 
        action: "destroy",
        format: "json"
      )
    end

  end
end