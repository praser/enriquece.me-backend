require "rails_helper"

RSpec.describe V1::AccountTypesController, type: :routing do
  describe "routing" do
  	let(:default_version) {"v1"}

    it "routes to #index" do
      expect(:get => "/account_types").to route_to(
        controller: "#{default_version}/account_types",
        action: "index",
        format: "json"
      )
    end
  end
end
