class AddGotPointToMeal < ActiveRecord::Migration
  def self.up
    add_column :meals, :got_point, :boolean, :default=>false
  end

  def self.down
    remove_column :meals, :got_point
  end
end
