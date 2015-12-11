class Check < ActiveRecord::Base
  belongs_to :card

  def run(params)
    result = SuperMemo.new(params).run
    self.update(times_reviewed: self.times_reviewed += 1)
    card.update(complexity: result, review_date: Time.zone.today + result.days)
  end
end
