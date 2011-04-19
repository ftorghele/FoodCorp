class CreateMealArrangements < ActiveRecord::Migration
  
  def self.up
    create_table :meal_arrangements do |t|
      t.integer :meal_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :meal_arrangements
  end
end
