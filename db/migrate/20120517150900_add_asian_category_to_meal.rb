class AddAsianCategoryToMeal < ActiveRecord::Migration
  def self.up
   add_column :meals, :asian, :boolean, :default => 0
  end

  def self.down
   remove_column :meals, :asian
  end
end
