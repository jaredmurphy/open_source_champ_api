require "rails_helper"

RSpec.describe LosersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/losers").to route_to("losers#index")
    end

    it "routes to #new" do
      expect(:get => "/losers/new").to route_to("losers#new")
    end

    it "routes to #show" do
      expect(:get => "/losers/1").to route_to("losers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/losers/1/edit").to route_to("losers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/losers").to route_to("losers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/losers/1").to route_to("losers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/losers/1").to route_to("losers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/losers/1").to route_to("losers#destroy", :id => "1")
    end

  end
end
