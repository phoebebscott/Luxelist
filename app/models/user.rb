class User < ActiveRecord::Base

validates_presence_of :first_name, :email, :password
validates_uniqueness_of :email
validates :password, length: {minimum: 6}

end
