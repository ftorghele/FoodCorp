class CreateRating < ActiveRecord::Migration
  def self.up
	create_table :rating do |t|
      t.integer :meal_id
      t.integer :user_id

      t.timestamps
    end

  add_index :rating, :meal_id
  add_index :rating, :user_id

  end

  def self.down
    drop_table :rating
  end
end
