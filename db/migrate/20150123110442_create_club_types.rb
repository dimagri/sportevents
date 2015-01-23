class CreateClubTypes < ActiveRecord::Migration
  def change
    create_table :club_types do |t|
      t.string :name
      t.integer :parent_id
      t.timestamps null: false
    end
  end
end
