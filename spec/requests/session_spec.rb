require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /autorization" do
    it "returns http success" do
      get "/session/autorization"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /checking" do
    it "returns http success" do
      get "/session/checking"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /log_out" do
    it "returns http success" do
      get "/session/log_out"
      expect(response).to have_http_status(:success)
    end
  end

end
