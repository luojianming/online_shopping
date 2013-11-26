require 'spec_helper'

describe "ShortSupplyRegistrations" do
  describe "GET /short_supply_registrations" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get short_supply_registrations_path
      response.status.should be(200)
    end
  end
end
