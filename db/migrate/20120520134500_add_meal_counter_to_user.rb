class AddMealCounterToUser < ActiveRecord::Migration
  def self.up
   add_column :users, :meal_counter, :integer, :default => 0
  end

  def self.down
   remove_column :users, :meal_counter
  end
end
