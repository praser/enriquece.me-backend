require "rails_helper"

RSpec.describe V1::UsersController, :type => :routing do
  describe "routing" do
    let(:default_version) {"v1"}

    it "routes to #index" do
      expect(:get => "/users").to route_to(
        controller: "#{default_version}/users",
        action: "index",
        format: "json"
      )
    end

    it "routes to #show" do
      expect(:get => "/users/1").to route_to(
        controller: "#{default_version}/users",
        action: "show",
        id: "1",
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
      expect(:put => "/users/1").to route_to(
        controller: "#{default_version}/users",
        action: "update",
        id: "1",
        format: "json"
      )
    end

    it "routes to #destroy" do
      expect(:delete => "/users/1").to route_to(
        controller: "#{default_version}/users", 
        action: "destroy",
        id: "1",
        format: "json"
      )
    end

  end
end