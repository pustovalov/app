require "rails_helper"

describe Check do
  let!(:card) { create(:card) }
  let!(:check) { create(:check, card: card) }

  it "has a valid factory" do
    expect(build :check).to be_valid
  end

  it "has complexity eq 2.5" do
    expect(card.complexity).to eq(2.5)
  end

  it "should be +1 day" do
    check.run(time: 1000, times_reviewed: 0)
    card.reload
    expect(card.review_date).to eq(Time.zone.today + 1.day)
  end

  it "should be +3 days" do
    check.run(time: 1000, times_reviewed: 1)
    card.reload
    expect(card.review_date).to eq(Time.zone.today + 3.days)
  end

  it "should be +3 days" do
    check.run(time: 1000, times_reviewed: 2, typos: 0, word_length: 15)
    card.reload
    expect(card.review_date).to eq(Time.zone.today + 3.days)
  end

  it "should be +5 days" do
    check.run(time: 1000, times_reviewed: 3, typos: 0, complexity: 2.6, word_length: 15)
    card.reload
    expect(card.review_date).to eq(Time.zone.today + 5.days)
  end

  it "should be +6 days" do
    check.run(time: 1000, times_reviewed: 5, typos: 0, complexity: 1, word_length: 15)
    card.reload
    expect(card.review_date).to eq(Time.zone.today + 6.days)
  end

  it "should be + 37 days" do
    check.run(time: 1000, times_reviewed: 10, typos: 0, complexity: 4, word_length: 15)
    card.reload
    expect(card.review_date).to eq(Time.zone.today + 37.days)
  end

  it "should be + 29 days" do
    check.run(time: 8000, times_reviewed: 10, typos: 20, complexity: 4, word_length: 15)
    card.reload
    expect(card.review_date).to eq(Time.zone.today + 29.days)
  end
end
