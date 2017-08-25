class RevertUsersZodiacColumn < ActiveRecord::Migration[5.0]
  def change
    change_column "users", "zodiac_id", :integer
  end
end
