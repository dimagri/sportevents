class RemoveClubAndEventFromLocations < ActiveRecord::Migration
  def change
    remove_columns :locations, :event_id, :club_id
  end
end
