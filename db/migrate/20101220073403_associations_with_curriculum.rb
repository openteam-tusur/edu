class AssociationsWithCurriculum < ActiveRecord::Migration
  def self.up
    rename_column :plan_semesters, :speciality_id, :curriculum_id
  end

  def self.down
    rename_column :plan_semesters, :curriculum_id, :speciality_id
  end
end
