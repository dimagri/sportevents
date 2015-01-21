class CreateCTypes < ActiveRecord::Migration
  def change
    create_table :c_types do |t|
      t.string :type
      
      t.timestamps null: false
    end
  end
end
