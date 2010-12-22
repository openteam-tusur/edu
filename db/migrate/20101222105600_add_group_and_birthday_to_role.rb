class AddGroupAndBirthdayToRole < ActiveRecord::Migration
  def self.up
    add_column :roles, :group, :string
    add_column :roles, :birthday, :date
  end

  def self.down
    remove_column :roles, :birthday
    remove_column :roles, :group
  end
end
