class CreateDisks < ActiveRecord::Migration
  def self.up
    create_table :disks do |t|
      t.string :year
      t.string :month
      t.integer :disk_id

      t.timestamps
    end
  end

  def self.down
    drop_table :disks
  end
end
