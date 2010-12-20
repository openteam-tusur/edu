class RenameFormToStudyInCurriculum < ActiveRecord::Migration
  def self.up
    rename_column :plan_curriculums, :form, :study
  end

  def self.down
    rename_column :plan_curriculums, :study, :form
  end
end
