require 'spec_helper'

describe ErrorsController do

  describe "GET 'not_fount'" do
    it "returns http success" do
      get 'not_fount'
      response.should be_success
    end
  end

  describe "GET 'server_error'" do
    it "returns http success" do
      get 'server_error'
      response.should be_success
    end
  end

end
