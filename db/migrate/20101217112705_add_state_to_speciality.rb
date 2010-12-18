class AddStateToSpeciality < ActiveRecord::Migration
  def self.up
    add_column :specialities, :state, :string
  end

  def self.down
    remove_column :specialities, :state
  end
end
