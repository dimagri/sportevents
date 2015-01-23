class DropClubsClubTypes < ActiveRecord::Migration
  def change
    drop_table :clubs
    drop_table :club_types
    drop_table :c_types
  end
end
