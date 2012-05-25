class ChangeTimeDeadline < ActiveRecord::Migration
  def change
    change_column :meals, :time, :datetime
    change_column :meals, :time, :datetime
  end
end
