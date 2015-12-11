require "rails_helper"

describe Card do
  it "has a valid factory" do
    expect(build :card).to be_valid
  end

  it "should have different original and translated text" do
    expect(
      build :card, original_text: " Du ", translated_text: "dU "
    ).to be_invalid
  end

  it "should have deck" do
    expect(
      build :card, :deck_nil
    ).to be_invalid
  end

  it "should have user" do
    expect(
      build :card, :user_nil
    ).to be_invalid
  end

  context "when check translation true" do
    it "should have success response" do
      card = build(:card)
      expect(card.check_translation("You ", 1000)[:success]).to be true
    end

    it "should have 0 typos" do
      card = build(:card)
      expect(card.check_translation("You ", 1000)[:typos]).to be 0
    end
  end

  context "when check translation false" do
    it "should have error" do
      card = build(:card)
      expect(card.check_translation("dsdasddas", 1000)[:success]).to be false
    end

    it "should have typos" do
      card = build(:card)
      expect(card.check_translation("dsdasddas", 1000)[:typos]).to be 9
    end
  end
end
