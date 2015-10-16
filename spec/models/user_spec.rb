require "rails_helper"

describe User do
  let!(:user) { create(:user) }
  let!(:card1) { user.cards.create(build(:card).attributes) }
  let!(:card2) { user.cards.create(build(:card, original_text: "3123").attributes) }

  it "has a valid factory" do
    expect(build :user).to be_valid
  end

  it "has many card" do
    expect(user.cards.count).to eq(2)
  end

  it "removes cards with user" do
    user.destroy
    expect(user.cards.count).to eq(0)
  end
end
