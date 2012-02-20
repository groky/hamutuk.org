class AddUserTypesAndLevelsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :type_id, :int
    add_column :users, :level_id, :int
  end

  def self.down
    remove_column :users, :level_id
    remove_column :users, :type_id
  end
end
