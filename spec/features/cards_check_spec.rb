require "rails_helper"

feature "Check cards" do
  context "cards are available for training" do
    let!(:card1) { create(:card) }
    let!(:card2) { create(:card, original_text: "someword", translated_text: "you") }

    before do
      visit root_path
    end

    scenario "opens successfully" do
      expect(page.status_code).to be 200
    end

    scenario "enter valid translation" do
      fill_in "card_translated_text", with: "you"
      find(".ac-check-submit").click
      expect(page).to have_content "Правильно"
    end

    scenario "enter invalid translation" do
      fill_in "card_translated_text", with: "132"
      find(".ac-check-submit").click
      expect(page).to have_content "Не правильно"
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
      expect(page).to have_content "Нету доступных карточек, приходи позже."
    end
  end
end
