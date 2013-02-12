require 'spec_helper'

describe PagesController do

  describe "GET 'main'" do
    it "returns http success" do
      get 'main'
      response.should be_success
    end
  end

  describe "GET 'description'" do
    it "returns http success" do
      get 'description'
      response.should be_success
    end
  end

end
