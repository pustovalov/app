class User < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  
  validates_presence_of :email, :password
end
