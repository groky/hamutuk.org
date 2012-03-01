class AddConfirmationHashToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :confirmation_hash, :string
  end

  def self.down
    remove_column :users, :confirmation_hash
  end
end
