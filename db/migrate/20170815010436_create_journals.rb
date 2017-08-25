class CreateJournals < ActiveRecord::Migration[5.0]
  def change
    create_table :journals do |t|
      t.references :user, foreign_key: true
      t.references :predict, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
