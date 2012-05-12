class ChangeCategoriesColumn < ActiveRecord::Migration
  def self.up
    add_column :meals, :hot, :boolean, :default =>0
    add_column :meals, :veryhot, :boolean, :default =>0
  end

  def self.down
    remove_column :meals, :hot
    remove_column :meals, :veryhot
  end
end
