class RenameHumenToHumans < ActiveRecord::Migration
  def self.up
    rename_table :humen, :humans
  end

  def self.down
    rename_table :humans, :humen
  end
end
