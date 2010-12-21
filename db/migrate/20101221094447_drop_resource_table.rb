class DropResourceTable < ActiveRecord::Migration
  def self.up
    drop_table :resources
  end

  def self.down
    create_table :resources
  end
end
