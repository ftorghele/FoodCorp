class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :body
      t.integer :user_id
      t.integer :meal_id
      t.integer :report_count, :default => 0
      t.boolean :visible, :default => false
      
      t.timestamps
    end
  end

  add_index :comments, :user_id,                :unique => true
  add_index :comments, :meal_id,                :unique => true

  def self.down
    drop_table :comments
  end
end
