class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.text :description
      t.string :adress
      t.integer :price
      t.integer :author
      t.integer :phone
      t.boolean :confermed, default: false

      t.timestamps null: false
    end
  end
end
