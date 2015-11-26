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

  scenario "change information" do
    click_link "Change Information"
    fill_in "user_email", with: "someemail@gmail.com"
    fill_in "user_password", with: password
    select("English", from: "user_locale")
    click_button "Change"
    expect(page).to have_content "Success"
  end

  scenario "not change information" do
    click_link "Change Information"
    fill_in "user_email", with: "someemail@gmail.com"
    fill_in "user_password", with: "1312"
    select("English", from: "user_locale")
    click_button "Change"
    expect(page).to have_content "Wrong password"
  end
end
