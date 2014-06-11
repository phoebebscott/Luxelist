class DropQueryTables < ActiveRecord::Migration
  def change
  	drop_table :queries
  	drop_table :query_results
  end
end
