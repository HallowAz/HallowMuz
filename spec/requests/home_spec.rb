require 'rails_helper'

RSpec.describe "Homes", type: :request do
  
  describe "GET /home" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /home_aut" do
    it "returns redirect when non authenticate" do
      get "/home_aut"
      expect(response).to have_http_status(302)
    end
  end

  describe "GET /profile" do
    it "returns redirect when non authenticate" do
      get "/profile"
      expect(response).to have_http_status(302)
    end
  end

  describe "GET /library" do
    it "returns redirect when non authenticate" do
      get "/library"
      expect(response).to have_http_status(302)
    end
  end

  describe "GET /search" do
    it "returns redirect when field is empty" do
      get "/search"
      expect(response).to have_http_status(302)
    end
  end


end
