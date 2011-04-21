class AddAcceptanceToMealArrangements < ActiveRecord::Migration
  def self.up
    add_column :meal_arrangements, :acceptance, :boolean
  end

  def self.down
    remove_column :meal_arrangements, :acceptance
  end
end
