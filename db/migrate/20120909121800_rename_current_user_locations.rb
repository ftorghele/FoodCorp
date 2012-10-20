class RenameCurrentUserLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.integer :user_id
      t.string :street
      t.integer :street_number
      t.integer :zip_code
      t.string :city

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
