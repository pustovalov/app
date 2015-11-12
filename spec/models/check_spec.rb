require "rails_helper"

describe Check do
  let!(:card) { create(:card) }
  let!(:check) { create(:check, card: card) }

  it "has a valid factory" do
    expect(build :check).to be_valid
  end

  it "has first box" do
    expect(check.box).to eq(1)
  end

  it "first right answer should be in first box" do
    check.mark_correct!
    expect(check.box).to eq(1)
  end

  it "decrease number for box" do
    check.mark_incorrect!
    expect(check.box).to eq(1)
  end

  it "should be +12 hours" do
    check.mark_correct!
    card.reload
    expect(card.review_date).to eq(Time.zone.today + 12.hours)
  end

  it "should be +3 days" do
    2.times { check.mark_correct! }
    card.reload
    expect(card.review_date).to eq(Time.zone.today + 72.hours)
  end

  it "should be +1 week" do
    3.times { check.mark_correct! }
    card.reload
    expect(card.review_date).to eq(Time.zone.today + 168.hours)
  end

  it "should be +2 weeks" do
    4.times { check.mark_correct! }
    card.reload
    expect(card.review_date).to eq(Time.zone.today + 336.hours)
  end

  it "should be +1 month" do
    5.times { check.mark_correct! }
    card.reload
    expect(card.review_date).to eq(Time.zone.today + 744.hours)
  end

  it "should be +12 hours after 3 failed attempts" do
    3.times { check.mark_correct! }
    3.times { check.mark_incorrect! }
    card.reload
    expect(card.review_date).to eq(Time.zone.today + 12.hours)
  end

end
