class AddWorkProgrammToPlanEducation < ActiveRecord::Migration
  def self.up
    add_column :plan_educations, :work_programm_id, :integer
  end

  def self.down
    remove_column :plan_educations, :work_programm_id
  end
end
