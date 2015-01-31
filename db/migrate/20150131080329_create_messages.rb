class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :author_id
      t.integer :recipient_id
      t.string :subject
      t.text :body
      t.boolean :deleted_author, default: false
      t.boolean :deleted_recipient, default: false

      t.timestamps null: false
    end
  end
end
