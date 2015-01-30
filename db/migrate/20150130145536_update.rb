class Update < ActiveRecord::Migration
  def change
    remove_column :events, :date
    add_column :events, :begins_at, :datetimerai
  end
end
