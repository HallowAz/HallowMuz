require 'rails_helper'

RSpec.describe "Singers", type: :request do
  describe "GET /profile" do
    it "returns http success" do
      get "/singers/profile"
      expect(response).to have_http_status(:success)
    end
  end

end
