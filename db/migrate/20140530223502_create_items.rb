class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.float :price
      t.string :location

      t.timestamps
    end
  end
end
