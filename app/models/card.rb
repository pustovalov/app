class Card < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image,
                    styles: { medium: "360x360" },
                    default_url: "/images/:style/card-default-image.jpg"

  validate :check_original_and_translated_text
  validates :original_text, uniqueness: true
  validates :original_text, :translated_text, :review_date, :user, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/]

  before_validation :sanitize_data

  scope :expired, -> {
    where("review_date <= ?", Time.zone.today)
  }

  scope :random, -> {
    order("RANDOM()").first
  }

  def sanitize_data
    self.original_text = original_text.mb_chars.strip.downcase!
    self.translated_text = translated_text.mb_chars.strip.downcase!
  end

  def check_original_and_translated_text
    if original_text == translated_text
      errors.add(:translated_text, "Must be different")
    end
  end

  def check_translation(text)
    translated_text == text.mb_chars.strip.downcase!
  end
end