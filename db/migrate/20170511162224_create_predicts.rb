class CreatePredicts < ActiveRecord::Migration[5.0]

 def change
    create_table :predicts do |t|
      t.integer :zodiac_id
      t.datetime :pred_date
      t.text :prediction

     t.timestamps
    end
  end
end
