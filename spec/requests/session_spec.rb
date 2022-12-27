require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /autorization" do
    it "returns http success" do
      get "/autorization"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /checking" do
    it "returns redirect" do
      post "/checking"
      expect(response).to have_http_status(302)
    end
  end

  describe "GET /log_out" do
    it "returns redirect" do
      post "/log_out"
      expect(response).to have_http_status(303)
    end
  end

end
