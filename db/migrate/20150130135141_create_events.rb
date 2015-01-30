class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :event_type_id
      t.integer :user_id
      t.string :name
      t.text :description
      t.string :date
      t.string :phone

      t.timestamps null: false
    end
  end
end
