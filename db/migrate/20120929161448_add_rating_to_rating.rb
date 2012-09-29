class AddRatingToRating < ActiveRecord::Migration
  def self.up
    add_column :ratings, :rating, :integer
  end

  def self.down
    remove_column :ratings, :rating
  end
end
