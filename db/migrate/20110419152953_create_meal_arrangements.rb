class CreateMealArrangements < ActiveRecord::Migration
  
  def self.up
    create_table :meal_arrangements do |t|
      t.integer :meal_id
      t.integer :user_id

      t.timestamps
    end

  add_index :meal_arrangements, :meal_id,                :unique => true
  add_index :meal_arrangements, :user_id,                :unique => true

  end


  def self.down
    drop_table :meal_arrangements
  end
end
