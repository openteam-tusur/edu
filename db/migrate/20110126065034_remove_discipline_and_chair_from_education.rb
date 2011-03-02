class RemoveDisciplineAndChairFromEducation < ActiveRecord::Migration
  def self.up
    remove_column :plan_educations, :discipline_id
    remove_column :plan_educations, :loading_lecture
    remove_column :plan_educations, :loading_laboratory
    remove_column :plan_educations, :loading_practice
    remove_column :plan_educations, :loading_course_project
    remove_column :plan_educations, :loading_course_work
    remove_column :plan_educations, :loading_self_training
    remove_column :plan_educations, :chair_id
  end

  def self.down
    add_column :plan_educations, :discipline_id, :integer
    add_column :plan_educations, :loading_lecture, :integer
    add_column :plan_educations, :loading_laboratory, :integer
    add_column :plan_educations, :loading_practice, :integer
    add_column :plan_educations, :loading_course_project, :integer
    add_column :plan_educations, :loading_course_work, :integer
    add_column :plan_educations, :loading_self_training, :integer
    add_column :plan_educations, :chair_id, :integer
  end
end

