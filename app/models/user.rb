class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  has_many :authentications, dependent: :destroy
  has_many :cards, dependent: :destroy

  accepts_nested_attributes_for :authentications

  validates :email, :password, presence: true
  validates :password, length: { minimum: 6 }
  validates :email, uniqueness: true, email: true
end
