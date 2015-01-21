class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :full_name, :string
    add_column :users, :email, :string
    add_column :users, :about, :text
    add_column :users, :phone, :string
    add_column :users, :skype, :string
  end
end
