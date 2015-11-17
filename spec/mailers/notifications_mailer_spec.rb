require "rails_helper"

describe NotificationsMailer do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user, id: 900, email: "seconduser@gmail.com") }
  let!(:card1) { user.cards.create(build(:card).attributes) }
  let!(:card2) { user2.cards.create(build(:card, original_text: "3123", review_date: (Time.zone.now + 5.days)).attributes) }

  context "pending cards" do
    it "should be only 1 email" do
      User.pending_cards
      @email = ActionMailer::Base.deliveries
      expect(@email.count).to eq 1
    end

    it "should send to right user" do
      User.pending_cards
      @email = ActionMailer::Base.deliveries
      expect(@email.first.to).to match_array(user.email)
    end
  end
end
