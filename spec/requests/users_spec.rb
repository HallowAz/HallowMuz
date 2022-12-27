require 'rails_helper'

RSpec.describe "/users", type: :request do
  
  let(:valid_attributes) {
    {:login => "test@mail.ru", :firstname => "test", :password => "testpassword", :passwordrepeat => "testpassword"}
  }

  let(:invalid_attributes) {
    {:login => "test", :firstname => "test", :password => "test"}
  }



  describe "GET /new" do
    it "renders a successful response" do
      get new_user_url
      expect(response).to be_successful
    end
  end


  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post users_url, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "redirects to the created user" do
        post users_url, params: { user: valid_attributes }
        expect(response).to redirect_to(home_aut_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post users_url, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
      end

    
      it "renders a response with 302 status (i.e. to display the 'new' template)" do
        post users_url, params: { user: invalid_attributes }
        expect(response).to have_http_status(302)
      end
    
    end
  end

end
