class AddCategoriesToMeal < ActiveRecord::Migration
  def self.up
   add_column :meals, :vegetarien, :boolean, :default => 0
   add_column :meals, :organic, :boolean, :default => 0
   add_column :meals, :kosher, :boolean, :default => 0
   add_column :meals, :halal, :boolean, :default => 0
   add_column :meals, :lactose_free, :boolean, :default => 0
   add_column :meals, :gluten_free, :boolean, :default => 0
   add_column :meals, :diabetics, :boolean, :default => 0
  end

  def self.down
   remove_column :meals, :vegetarien
   remove_column :meals, :organic
   remove_column :meals, :kosher
   remove_column :meals, :halal
   remove_column :meals, :lactose_free
   remove_column :meals, :gluten_free
   remove_column :meals, :diabetics
  end
end
