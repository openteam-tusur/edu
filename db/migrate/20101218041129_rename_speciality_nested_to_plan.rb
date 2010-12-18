class RenameSpecialityNestedToPlan < ActiveRecord::Migration
  def self.up
    rename_table :speciality_specialities, :specialities
    rename_table :speciality_accreditations, :plan_accreditations
    rename_table :speciality_disciplines, :plan_disciplines
    rename_table :speciality_educations, :plan_educations
    rename_table :speciality_licences, :plan_licences
    rename_table :speciality_semesters, :plan_semesters
  end

  def self.down
    rename_table :specialities, :speciality_specialities
    rename_table :plan_accreditations, :speciality_accreditations
    rename_table :plan_disciplines, :speciality_disciplines
    rename_table :plan_educations, :speciality_educations
    rename_table :plan_licences, :speciality_licences
    rename_table :plan_semesters, :speciality_semesters
  end
end
