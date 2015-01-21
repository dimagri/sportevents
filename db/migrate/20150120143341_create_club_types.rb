class CreateClubTypes < ActiveRecord::Migration
  def change
    create_table :club_types do |t|
      t.integer :club_id
      t.integer :c_type_id
      t.string :subtype

      t.timestamps null: false
    end
  end
end
