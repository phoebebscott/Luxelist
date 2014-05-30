class User < ActiveRecord::Base

validates_presence_of :first_name, :email, :password
validates_uniqueness_of :email
validates :password, length: {minimum: 6}
validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/

has_many :, through: :query_results
has_many :items, through: :favorites
end
