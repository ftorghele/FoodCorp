class AddTimesToMeal < ActiveRecord::Migration
  def self.up
    add_column :meals, :times, :datetime
    add_column :meals, :deadline_time, :datetime
  end

  def self.down
    remove_column :meals, :times
    remove_column :meals, :deadline_time
  end
end

