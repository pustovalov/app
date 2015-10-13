require 'rails_helper'

describe Card do
  it 'has a valid factory' do
    expect(build :card).to be_valid
  end
  
  it 'should have different original and translated text' do
    expect(build :card, original_text: " Du ", translated_text: "dU ").to be_invalid
  end
  
  context "when check translation true" do
    it "check translation" do
      card = build(:card)
      expect(card.check_translation("You ")).to be true
    end
  end

  context "when check translation false" do
    it "check translation" do
      card = build(:card)
      expect(card.check_translation("dsdasddas")).to be false
    end
  end
end
