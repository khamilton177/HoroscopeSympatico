class DropJournals < ActiveRecord::Migration[5.0]
  def change
    drop_table :journals
  end
end
