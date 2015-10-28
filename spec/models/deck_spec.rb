require "rails_helper"

describe Deck do
  let!(:deck) { create(:deck) }
  let!(:card1)  { create(:card) }
  let!(:card2) { create(:card, original_text: "someword", translated_text: "you") }

  it "has a valid factory" do
    expect(build :deck).to be_valid
  end

  it "should have unique name" do
    expect(build(:deck, id: "123")).to be_invalid
  end

  it "should have one current deck" do
    create(:deck, :current, name: "1", id: "100")
    expect(build(:deck, :current, name: "2", id: "101")).to be_invalid
  end

  it "has many card" do
    expect(deck.cards.count).to eq(2)
  end

  it "removes cards with deck" do
    deck.destroy
    expect(deck.cards.count).to eq(0)
  end
end
