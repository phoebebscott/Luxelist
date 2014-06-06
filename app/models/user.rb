require 'bcrypt'

class User < ActiveRecord::Base

validates_presence_of :first_name, :email, :password
validates_uniqueness_of :email
validates :password, length: {minimum: 6}
validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/

has_many :queries, through: :query_results

# not sure if we need the favorites, but think so(mk)
has_many :favorites

has_many :items, through: :favorites


def password
    @password
  end

  def password=(new_password)
    @password = new_password
    self.password_digest = BCrypt::Password.create(new_password)
  end

  def authenticate(test_password)
    if BCrypt::Password.new(self.password_digest) == test_password
      self
    else
      false
    end
  end

end
