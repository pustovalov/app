class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :decks, dependent: :destroy

  accepts_nested_attributes_for :authentications

  validates :email, :password, presence: true
  validates :password, length: { minimum: 6 }
  validates :email, uniqueness: true, email: true

  def self.pending_cards
    User.joins(:cards).merge(Card.expired).uniq.each do |user|
      NotificationsMailer.pending_cards(user).deliver
    end
  end
end
