require "rails_helper"

describe "Settings" do
  let(:password) { attributes_for(:user)[:password] }
  let!(:user) { create(:user) }
  before do
    login user, password
    visit settings_path
  end
  
  scenario "opens successfully" do
    expect(page.status_code).to be 200
  end
  
  scenario "change email" do
    click_link "Change Email"
    fill_in "user_email", with: "someemail@gmail.com"
    fill_in "user_password", with: password
    click_button "Change"
    expect(page).to have_content "Email was successfully updated."
  end
  
  scenario "change password" do
    click_link "Change Password"
    fill_in "user_password", with: password
    fill_in "user_new_password", with: "newpassword"
    click_button "Change"
    expect(page).to have_content "Password was successfully updated."
  end
end
