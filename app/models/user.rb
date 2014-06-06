require 'bcrypt'

class User < ActiveRecord::Base
  before_save {self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: {minimum: 6}, on: :create

# not sure if we need the favorites, but think so(mk)
  has_many :favorites
  has_many :items, through: :favorites
  has_many :queries, through: :query_results
end
