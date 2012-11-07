require 'spec_helper'

describe AdminController do

  describe "GET 'userlist'" do
    it "returns http success" do
      get 'userlist'
      response.should be_success
    end
  end

  describe "GET 'shoplist'" do
    it "returns http success" do
      get 'shoplist'
      response.should be_success
    end
  end

  describe "GET 'couponlist'" do
    it "returns http success" do
      get 'couponlist'
      response.should be_success
    end
  end

  describe "GET 'shop'" do
    it "returns http success" do
      get 'shop'
      response.should be_success
    end
  end

end
