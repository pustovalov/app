require "rails_helper"

describe "Check cards" do
  let(:password) { attributes_for(:user)[:password] }
  let(:user) { create(:user) }
  
  before do
    login user, password
  end
  
  context "cards are available for training" do
    let(:card1)  { user.cards.create(build(:card).attributes) }
    let(:card2) { user.cards.create(build(:card, original_text: "someword", translated_text: "you").attributes) }

    scenario "opens successfully" do
      expect(page.status_code).to be 200
    end

    scenario "enter valid translation" do
      # byebug
      fill_in "card_translated_text", with: "you"
      find(".ac-check-submit").click
      expect(page).to have_content "Correct"
    end

    scenario "enter invalid translation" do
      fill_in "card_translated_text", with: "132"
      find(".ac-check-submit").click
      expect(page).to have_content "Wrong"
    end
  end

  context "cards are not available for training" do
    before do
      visit root_path
    end

    scenario "opens successfully" do
      expect(page.status_code).to be 200
    end

    scenario "no available cards" do
      expect(page).to have_content "You don't have enough words. Add them via \"Add card\""
    end
  end
end
