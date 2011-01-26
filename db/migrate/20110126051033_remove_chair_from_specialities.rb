class RemoveChairFromSpecialities < ActiveRecord::Migration
  def self.up
    remove_column :specialities, :chair_id
  end

  def self.down
    add_column :specialities, :chair_id, :integer
  end
end

