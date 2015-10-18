class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :cards, dependent: :destroy

  validates :email, :password, presence: true
  validates :password, length: { minimum: 6 }
  validates :email, uniqueness: true, email: true
end
