require "spec_helper"

describe ConstantTextsController do
  describe "routing" do

    it "routes to #index" do
      get("/constant_texts").should route_to("constant_texts#index")
    end

    it "routes to #new" do
      get("/constant_texts/new").should route_to("constant_texts#new")
    end

    it "routes to #show" do
      get("/constant_texts/1").should route_to("constant_texts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/constant_texts/1/edit").should route_to("constant_texts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/constant_texts").should route_to("constant_texts#create")
    end

    it "routes to #update" do
      put("/constant_texts/1").should route_to("constant_texts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/constant_texts/1").should route_to("constant_texts#destroy", :id => "1")
    end

  end
end
