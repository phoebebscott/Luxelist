class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  validates_presence_of :external_url
  validates_presence_of :external_id
  validates_presence_of :image_url
end
