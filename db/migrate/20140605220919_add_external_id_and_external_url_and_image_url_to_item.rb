class AddExternalIdAndExternalUrlAndImageUrlToItem < ActiveRecord::Migration
  def change
    add_column :items, :external_id, :integer
    add_column :items, :external_url, :string
    add_column :items, :image_url, :string
  end
end
