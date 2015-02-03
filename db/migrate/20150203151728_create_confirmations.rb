class CreateConfirmations < ActiveRecord::Migration
  def change
    create_table :confirmations do |t|
      t.belongs_to :user, index: true
      t.string :email
      t.string :code

      t.timestamps null: false
    end
    add_foreign_key :confirmations, :users
  end
end
