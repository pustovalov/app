class Deck < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  belongs_to :user

  validates_uniqueness_of :current, conditions: -> { where(current: true) }
  validates :name, uniqueness: true, presence: true

  default_scope { order(:id) }
  scope :current, -> { where current: true }
end
