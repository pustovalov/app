class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  has_many :checks, dependent: :destroy
  has_attached_file :image,
                    styles: { medium: "360x360" },
                    default_url: "/images/:style/card-default-image.jpg"

  validate :check_original_and_translated_text
  validates :original_text, uniqueness: true
  validates :original_text, :translated_text, :review_date, :user, :deck, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/]

  attr_accessor :time

  before_validation :sanitize_data

  scope :expired, -> {
    where("review_date <= ?", Time.zone.today)
  }

  scope :random, -> {
    order("RANDOM()").first
  }

  scope :current_deck, -> {
    joins(:deck).where("current = ?", true)
  }

  def sanitize_data
    self.original_text = original_text.mb_chars.strip.downcase!
    self.translated_text = translated_text.mb_chars.strip.downcase!
  end

  def check_original_and_translated_text
    if original_text == translated_text
      errors.add(:translated_text, I18n.t("notifications.must_different"))
    end
  end

  def check_translation(text, time)
    check = Check.find_or_create_by(card: self)
    typos = Text::Levenshtein.distance(translated_text, text.mb_chars.strip.downcase!)
    check.run(typos: typos, times_reviewed: check.times_reviewed, word_length: text.length, time: time, complexity: complexity)
    if typos.zero?
      { success: true, typos: typos }
    else
      { success: false, typos: typos }
    end
  end
end