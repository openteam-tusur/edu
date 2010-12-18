class RenameEducationAssociations < ActiveRecord::Migration
  def self.up
    rename_column :speciality_educations, :speciality_discipline_id, :discipline_id
    rename_column :speciality_educations, :speciality_semester_id, :semester_id
  end

  def self.down
    rename_column :speciality_educations, :discipline_id, :speciality_discipline_id
    rename_column :speciality_educations, :semester_id, :speciality_semester_id
  end
end
