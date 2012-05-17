class AddGotInvitationToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :got_invitation, :boolean, :default =>0
  end

  def self.down
   remove_column :users, :got_invitation
  end
end
