class AddOtherToRole < ActiveRecord::Migration
  def self.up
    add_column :roles, :other, :string
  end

  def self.down
    remove_column :roles, :other	
  end
end
