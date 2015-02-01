class UpdateLocations < ActiveRecord::Migration
  def change
    add_reference :locations, :locationable, polymorphic: true, index: true
  end
end
