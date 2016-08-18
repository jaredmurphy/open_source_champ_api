require "rails_helper"

RSpec.describe WinnersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/winners").to route_to("winners#index")
    end

    it "routes to #new" do
      expect(:get => "/winners/new").to route_to("winners#new")
    end

    it "routes to #show" do
      expect(:get => "/winners/1").to route_to("winners#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/winners/1/edit").to route_to("winners#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/winners").to route_to("winners#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/winners/1").to route_to("winners#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/winners/1").to route_to("winners#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/winners/1").to route_to("winners#destroy", :id => "1")
    end

  end
end
