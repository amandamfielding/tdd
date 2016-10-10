# spec/features/auth_spec.rb

require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end
end

feature "signing up a user" do
    scenario "shows username on the homepage after signup" do
      visit new_user_url
      fill_in 'Username', with: "testing_username"
      fill_in 'Password', with: 'biscuits'
      click_on 'Submit'
      expect(page).to have_content "testing_username"
    end
end

feature "logging in" do
  before(:each) do
      visit new_user_url
      fill_in 'username', :with => "testing_username"
      fill_in 'password', :with => "biscuits"
      click_on "Submit"
    end
  scenario "shows username on the homepage after login" do
    visit new_session_url
    fill_in 'Username', with: "testing_username"
    fill_in 'Password', with: 'biscuits'
    click_on 'Submit'
    expect(page).to have_content "testing_username"
  end

end

feature "logging out" do

  scenario "begins with a logged out state" do
    visit goals_url
    expect(page).to have_content "Username"
  end

  scenario "doesn't show username on the homepage after logout" do
    visit new_user_url
    fill_in 'Username', with: "testing_username"
    fill_in 'Password', with: 'biscuits'
    click_on 'Submit'
    click_on 'Log Out'
    expect(page).not_to have_content("testing_username")
  end

end
