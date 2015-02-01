class UpdateLocations < ActiveRecord::Migration
  def change
    remove_column :locations, :club_id, :event_id
    add_reference :locations, :locationable, polymorphic: true, index: true
  end
end
