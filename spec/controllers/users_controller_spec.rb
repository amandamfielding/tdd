require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders new page" do
      get :new, user: {}
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates presence of username and password" do
        post :create, user: {username: '1234'}
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end
    end
    context "with valid params" do
      it "redirects to goals index page" do
        post :create, user: {username: '1234', password:'hunter2'}
        expect(response).to redirect_to(goals_url)
      end
      it "logs in the user" do
        post :create, user: {username: '1234', password:'hunter2'}
        user = User.find_by_username("1234")
        expect(session[:session_token]).to eq(user.session_token)
      end
    end
  end
end
