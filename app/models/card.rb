class Card < ActiveRecord::Base
  validates_uniqueness_of :original_text
  validates_presence_of :original_text, :translated_text, :review_date
  validate :check_original_and_translated_text
  
  def check_original_and_translated_text
    if original_text.mb_chars.downcase == translated_text.mb_chars.downcase
      errors.add(:translated_text, "Не может быть одинаковым") 
    end
  end
end
