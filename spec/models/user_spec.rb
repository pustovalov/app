require "rails_helper"

describe User do
  let!(:user) { create(:user) }

  it "has a valid factory" do
    expect(build :user).to be_valid
  end

  it "has many card" do
    user.cards.create(build(:card).attributes)
    user.cards.create(build(:card, original_text: "3123").attributes)
    expect(user.cards.count).to eq(2)
  end

  it "removes cards with user" do
    user.cards.create(build(:card).attributes)
    user.cards.create(build(:card, original_text: "3123").attributes)
    user.destroy
    expect(user.cards.count).to eq(0)
  end
end
