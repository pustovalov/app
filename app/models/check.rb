class Check < ActiveRecord::Base
  belongs_to :card

  hours = [12, 3, 7, 14, 31]

  DELAYS = hours.map{ |element| element == hours.first ? element : element * 24 }

  NUMBER_OF_FAILS = 2

  def mark_correct!
    increment_wins
    set_review_date
    save
  end

  def mark_incorrect!
    if losing_streak < NUMBER_OF_FAILS
      increment_losses
    else
      reset_losses
    end
    set_review_date
    save
  end

  protected

  def increment_losses
    self.times_reviewed += 1
    self.losing_streak += 1
  end

  def increment_wins
    if !times_reviewed.zero?
      self.box += 1
    end
    self.times_reviewed += 1
    self.losing_streak = 0
  end

  def reset_losses
    self.losing_streak = 0
    self.box = 1
  end

  def set_review_date
    card.review_date = Time.zone.today + DELAYS[[DELAYS.count, box].min-1].hours
    card.save
  end
end
