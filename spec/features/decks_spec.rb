require "rails_helper"

describe "Decks" do
  let(:password) { attributes_for(:user)[:password] }
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck) }

  before do
    login user, password
    visit decks_path
  end

  scenario "opens successfully" do
    expect(page.status_code).to be 200
  end

  scenario "add new deck" do
    click_link "Add"
    fill_in "deck_name", with: "new deck"
    click_button "Add"
    expect(page).to have_content "new deck"
  end

  scenario "make current deck" do
    click_link("Make current")
    expect(page).to have_no_content "Make current"
  end

  scenario "remove deck" do
    click_link("Delete")
    expect(page).to have_css(".ac-deck", count: 0)
  end
end
