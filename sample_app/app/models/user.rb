class User < ApplicationRecord
  validates :name, 
    presence: true, 
    length: { maximum: 50 }
  validates :email, 
    presence: true, 
    length: { maximum: 255 },
    uniqueness: true,
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password,
    length: { minimum: 6 },
    presence: true

  before_save { self.email = email.downcase }

  has_secure_password
end
