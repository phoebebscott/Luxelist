class Item < ActiveRecord::Base
	has_many :favorites
	has_many :users, through: :favorites
	validates_presence_of :title
	validates_presence_of :location
	validates_presence_of :price	
end
