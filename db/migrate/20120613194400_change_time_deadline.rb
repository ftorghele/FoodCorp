class ChangeTimeDeadline < ActiveRecord::Migration
  def self.up
    remove_column :meals, :time
    remove_column :meals, :deadline
    
    add_column :meals, :time, :date
    add_column :meals, :deadline, :date
  end

  def self.down
    remove_column :meals, :time
    remove_column :meals, :deadline
  end
end
