class CreateUserPredict < ActiveRecord::Migration[5.0]
  def change
    create_join_table :users, :predicts do |t|
    t.index [:user_id, :predict_id]
    t.index [:predict_id, :user_id]
    t.text :comment
    end
  end
end
