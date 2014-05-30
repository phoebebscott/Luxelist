class CreateQueryResults < ActiveRecord::Migration
  def change
    create_table :query_results do |t|

      t.timestamps
    end
  end
end
