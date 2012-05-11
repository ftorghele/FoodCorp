class AddEmailAdresseToUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :email_adresse
  end

  def self.down
   remove_column :users, :email_adresse
  end
end
