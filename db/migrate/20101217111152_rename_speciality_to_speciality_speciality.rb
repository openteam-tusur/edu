class RenameSpecialityToSpecialitySpeciality < ActiveRecord::Migration
  def self.up
    rename_table :specialities, :speciality_specialities
  end

  def self.down
    rename_table :speciality_specialities, :speciality
  end
end
