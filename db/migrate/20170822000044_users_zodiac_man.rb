class UsersZodiacMan < ActiveRecord::Migration[5.0]
  def change
    change_column_null :users, :zodiac_id, false
  end
end
