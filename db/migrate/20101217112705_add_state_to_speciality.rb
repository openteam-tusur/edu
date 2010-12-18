class AddStateToSpeciality < ActiveRecord::Migration
  def self.up
    add_column :speciality_specialities, :state, :string
  end

  def self.down
    remove_column :speciality_specialities, :state
  end
end

