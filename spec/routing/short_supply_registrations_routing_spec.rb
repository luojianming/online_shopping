require "spec_helper"

describe ShortSupplyRegistrationsController do
  describe "routing" do

    it "routes to #index" do
      get("/short_supply_registrations").should route_to("short_supply_registrations#index")
    end

    it "routes to #new" do
      get("/short_supply_registrations/new").should route_to("short_supply_registrations#new")
    end

    it "routes to #show" do
      get("/short_supply_registrations/1").should route_to("short_supply_registrations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/short_supply_registrations/1/edit").should route_to("short_supply_registrations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/short_supply_registrations").should route_to("short_supply_registrations#create")
    end

    it "routes to #update" do
      put("/short_supply_registrations/1").should route_to("short_supply_registrations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/short_supply_registrations/1").should route_to("short_supply_registrations#destroy", :id => "1")
    end

  end
end
