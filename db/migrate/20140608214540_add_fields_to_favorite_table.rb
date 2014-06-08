class AddFieldsToFavoriteTable < ActiveRecord::Migration
  def change
    add_column :favorites, :price, :string
    add_column :favorites, :external_id, :integer
    add_column :favorites, :external_url, :string
    add_column :favorites, :image_url, :string
    add_column :favorites, :heading, :string
    add_column :favorites, :cityName, :string
  end
end
