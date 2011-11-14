class RefactorToDisk < ActiveRecord::Migration
  def self.up
    remove_column :disks, :disk_id
    remove_column :disks, :year
    remove_column :disks, :month
    add_column :disks, :released_on, :date
  end

  def self.down
    add_column :disks, :disk_id, :integer
    add_column :disks, :year, :string
    add_column :disks, :month, :string
    remove_column :disks, :released_on
  end
end

