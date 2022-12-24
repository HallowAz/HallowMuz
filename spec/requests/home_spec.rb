require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /home" do
    it "returns http success" do
      get "/home/home"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /home_aut" do
    it "returns http success" do
      get "/home/home_aut"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /profile" do
    it "returns http success" do
      get "/home/profile"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /library" do
    it "returns http success" do
      get "/home/library"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /search" do
    it "returns http success" do
      get "/home/search"
      expect(response).to have_http_status(:success)
    end
  end

end
