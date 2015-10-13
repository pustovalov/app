class Card < ActiveRecord::Base
  validates :original_text, uniqueness: true
  validates_presence_of :original_text, :translated_text, :review_date
  validate :check_original_and_translated_text
  before_validation :sanitize_data
  scope :expired, -> {
    where("review_date <= ?", Time.zone.today)
  }
  scope :random, -> {
    order("RANDOM()").first
  }
  
  def sanitize_data
    self.original_text = self.original_text.mb_chars.strip.downcase!
    self.translated_text = self.translated_text.mb_chars.strip.downcase!
  end
  
  def check_original_and_translated_text
    if original_text == translated_text
      errors.add(:translated_text, "Не может быть одинаковым")
    end
  end
  
  def check_translation(text)
    translated_text == text.mb_chars.strip.downcase!
  end
end