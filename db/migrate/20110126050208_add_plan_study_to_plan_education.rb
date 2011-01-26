class AddPlanStudyToPlanEducation < ActiveRecord::Migration
  def self.up
    add_column :plan_educations, :study_id, :integer
  end

  def self.down
    remove_column :plan_educations, :study_id
  end
end

