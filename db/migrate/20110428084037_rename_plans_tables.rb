class RenamePlansTables < ActiveRecord::Migration
  def self.up
    rename_table :plan_accreditations, :accreditations
    rename_table :plan_curriculums, :curriculums
    rename_table :plan_cycles, :cycles
    rename_table :plan_disciplines, :disciplines
    rename_table :plan_educations, :educations
    rename_table :plan_licences, :licences
    rename_table :plan_semesters, :semesters
    rename_table :plan_studies, :studies
  end

  def self.down
    rename_table :studies, :plan_studies
    rename_table :semesters, :plan_semesters
    rename_table :licences, :plan_licences
    rename_table :educations, :plan_educations
    rename_table :disciplines, :plan_disciplines
    rename_table :cycles, :plan_cycles
    rename_table :curriculums, :plan_curriculums
    rename_table :accreditations, :plan_accreditations
  end
end
