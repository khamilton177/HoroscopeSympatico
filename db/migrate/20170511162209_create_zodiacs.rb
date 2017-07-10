class CreateZodiacs < ActiveRecord::Migration[5.0]
  def change
    create_table :zodiacs do |t|
      t.string :sign

     t.timestamps
    end
  end
end
