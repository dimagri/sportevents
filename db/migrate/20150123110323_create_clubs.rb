class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.integer :club_type_id
      t.integer :user_id
      t.string :name
      t.text :description
      t.integer :price
      t.string :phone
      t.boolean :confirmed

      t.timestamps null: false
    end
  end
end
