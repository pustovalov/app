class Card < ActiveRecord::Base
  validates :original_text, uniqueness: true
  validates_presence_of :original_text, :translated_text, :review_date
  validate :check_original_and_translated_text
  
  scope :expired, -> {
    where("review_date <= ?", Time.zone.today)
  }
  
  scope :random, -> {
    order("RANDOM()").first
  }
  
  def check_original_and_translated_text
    if original_text.mb_chars.downcase == translated_text.mb_chars.downcase
      errors.add(:translated_text, "Не может быть одинаковым") 
    end
  end
end
