class AddActivateToUserLocation < ActiveRecord::Migration
  def self.up
   add_column :locations, :activate, :boolean, :default => true
  end

  def self.down
   remove_column :locations, :activate
  end
end
