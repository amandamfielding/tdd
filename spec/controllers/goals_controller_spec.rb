require 'rails_helper'
require 'spec_helper'
RSpec.describe GoalsController, type: :controller do

  let(:jill) { User.create!(username: 'jill_bruce', password: 'abcdef') }
  before(:each) do
   allow(controller).to receive(:current_user) { jill }
  end

  describe "GET #new" do
    it "renders a new goals page" do
      get :new, goal:{}
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with invalid params" do

      it "validates presence of title" do
        post :create, goal: {random:"hi"}
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "redirects to goal page" do
        post :create, goal: {title: "Pass assessment 4"}
        expect(response).to redirect_to(goal_url(Goal.first))
      end
    end
  end

  describe "GET #edit" do
    # before do
      create_jill_with_goal('title')
    # end
    it "renders a the goal edit page" do
      get :edit, id: goal.id
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    create_jill_with_goal('title')
    context "with invalid params" do
      it "validates presence of title" do
        debugger
        patch :update, id: goal.id, goal: {title:"",private:true}
        expect(response).to render_template(:edit)
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      # before do
      #  make_goal("pass assessment 4")
      # end
      it "redirects to goal page" do
        patch :update, id: goal.id, goal: {title: "Pass assessment 5"}
        expect(response).to redirect_to(goal_url(goal.id))
      end
    end
  end

  describe "GET #index" do
    it "renders the index page when logged in" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "renders the show page" do
      get :show, id:1
      expect(response).to render_template(:show)
    end
  end

  describe "DELETE #destroy" do
    create_jill
    it "removes a goal and redirects to index" do
      goal = Goal.create(title:"pass assessment 3")
      delete :destroy, id:1
      expect(Goal.find_by_id(1)).to be_nil
      expect(response).to redirect_to(goals_url)
    end
  end
end
