class AddChoicesToMeal < ActiveRecord::Migration
  def self.up
    add_column :meals, :eat_in, :boolean, :default=>0
    add_column :meals, :take_away, :boolean, :default=>0
  end

  def self.down
    remove_column :meals, :eat_in
    remove_column :meals, :take_away
  end
end
