class AddSlotsToMeals < ActiveRecord::Migration
  def self.up
    add_column :meals, :slots, :integer
  end

  def self.down
    remove_column :meals, :slots
  end
end
