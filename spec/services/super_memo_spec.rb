require "rails_helper"

describe SuperMemo do
  let(:first_good_answer) { SuperMemo.new(time: 500, times_reviewed: 0, typos: 0, word_length: 15).run }
  let(:second_good_answer) { SuperMemo.new(time: 500, times_reviewed: 1, typos: 0, word_length: 15).run }
  let(:third_good_answer) { SuperMemo.new(time: 500, times_reviewed: 3, typos: 0, word_length: 15).run }
  let(:third_answer_with_typos) { SuperMemo.new(time: 500, times_reviewed: 3, typos: 5, word_length: 15).run }
  let(:third_bad_answer) { SuperMemo.new(time: 500, times_reviewed: 3, typos: 20, word_length: 15).run }

  let(:good_delay_true) { SuperMemo.new(time: 30000).response_quality }
  let(:normal_delay_true) { SuperMemo.new(time: 65000).response_quality }
  let(:bad_delay_true) { SuperMemo.new(time: 300000).response_quality }

  let(:rating_5) { SuperMemo.new(time: 500, typos: 0).rating }
  let(:rating_4) { SuperMemo.new(time: 65000, typos: 0).rating }
  let(:rating_3) { SuperMemo.new(time: 300000, typos: 0).rating }
  let(:rating_2) { SuperMemo.new(typos: 2, word_length: 20).rating }
  let(:rating_1) { SuperMemo.new(typos: 8, word_length: 30).rating }
  let(:rating_0) { SuperMemo.new(typos: 20, word_length: 30).rating }

  context "response quality" do
    it "should be 1" do
      expect(good_delay_true).to be(1)
    end

    it "should be 2" do
      expect(normal_delay_true).to be(2)
    end

    it "should be 3" do
      expect(bad_delay_true).to be(3)
    end
  end

  context "rating" do
    it "should be 5" do
      expect(rating_5).to be(5)
    end

    it "should be 4" do
      expect(rating_4).to be(4)
    end

    it "should be 3" do
      expect(rating_3).to be(3)
    end

    it "should be 2" do
      expect(rating_2).to be(2)
    end

    it "should be 1" do
      expect(rating_1).to be(1)
    end

    it "should be 0" do
      expect(rating_0).to be(0)
    end
  end

  context "run" do
    it "should be 1 day" do
      expect(first_good_answer).to be(1)
    end

    it "should be 3 days" do
      expect(second_good_answer).to be(3)
    end

    it "should be 5 days" do
      expect(third_good_answer).to be(5)
    end

    it "should be 3 days" do
      expect(third_answer_with_typos).to be(3)
    end

    it "should be 3 days" do
      expect(third_bad_answer).to be(3)
    end
  end
end
