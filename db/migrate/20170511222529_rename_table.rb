class RenameTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :predicts_users, :journals

 end
end
