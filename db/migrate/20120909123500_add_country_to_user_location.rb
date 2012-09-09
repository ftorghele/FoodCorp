class AddCountryToUserLocation < ActiveRecord::Migration
  def self.up
    add_column :locations, :country, :text
  end

  def self.down
   remove_column :locations, :country
  end
end
