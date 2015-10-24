require "rails_helper"

describe "Authorization" do  
  let(:password) { attributes_for(:user)[:password] }
  let!(:user) { create(:user) }
  before do
    visit root_path
  end
  
  scenario "opens successfully" do
    expect(page.status_code).to be 200
  end
  
  describe "sign up" do
    scenario "when valid" do
      visit sign_up_path
      fill_in "user_email", with: "11111@gmail.com"
      fill_in "user_password", with: "31232113131"
      find(".ac-signup-submit").click
      expect(page).to have_content "Log Out"
    end
    
    scenario "when no valid" do
      visit sign_up_path
      fill_in "user_email", with: "11111"
      fill_in "user_password", with: "31232113131"
      find(".ac-signup-submit").click
      expect(page).to have_content "is invalid"
    end
  end
  
  describe "login in" do
    scenario "when valid" do
      visit log_in_path
      fill_in "user_email", with: user.email
      fill_in "user_password", with: password
      find(".ac-login-submit").click
      expect(page).to have_content "Log Out"
    end
    
    scenario "when not valid" do
      visit log_in_path
      fill_in "user_email", with: "1231323"
      fill_in "user_password", with: "31231"
      find(".ac-login-submit").click
      expect(page).to have_content "E-mail and/or password is incorrect."
    end
  end
  
  describe "login out" do
    before do
      login user, password
    end
    
    scenario "when valid" do
      click_link "Log Out"
      expect(page).to have_content "See you!"
    end
  end
end
