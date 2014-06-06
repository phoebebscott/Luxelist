class RemoveNameAndPasswordFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :password, :string
    remove_column :users, :first_name, :string
  end
end
