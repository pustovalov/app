class Check < ActiveRecord::Base
  belongs_to :card

  DELAYS = [12, 3*24, 7*24, 14*24, 31*24]

  NUMBER_OF_FAILS = 2

  def mark_correct!
    increment_wins
    self.set_review_date
    self.save
  end

  def mark_incorrect!
    if self.losing_streak < NUMBER_OF_FAILS
      increment_losses
    else
      reset_losses
    end
    self.set_review_date
    self.save!
  end

  protected

  def increment_losses
    self.times_reviewed += 1
    self.losing_streak  += 1
  end

  def increment_wins
    if !self.times_reviewed.zero?
      self.box          += 1
    end
    self.times_reviewed += 1
    self.losing_streak   = 0
  end

  def reset_losses
    self.losing_streak   = 0
    self.box             = 1
  end

  def set_review_date
    self.card.review_date = Time.zone.today + DELAYS[[DELAYS.count, box].min-1].hours
    self.card.save
  end
end
