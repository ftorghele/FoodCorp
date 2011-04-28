class ChangeMealsColumn < ActiveRecord::Migration
  def self.up
    change_table :meals do |t|
      t.change :time, :integer
      t.change :deadline, :integer
    end
  end

  def self.down
    change_table :meals do |t|
      t.change :time, :datetime
      t.change :deadline, :datetime
    end
  end
end
