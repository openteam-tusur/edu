class RenameStudyToStudyFormFromCurriculum < ActiveRecord::Migration
  def self.up
    rename_column :curriculums, :study, :study_form
  end

  def self.down
    rename_column :curriculums, :study_form, :study
  end
end
