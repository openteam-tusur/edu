class RenameResourceEducationToResourceDiscipline < ActiveRecord::Migration
  def self.up
    rename_table :resource_educations, :resource_disciplines
    rename_column :resource_disciplines, :education_id, :discipline_id
  end

  def self.down
    rename_column :resource_disciplines, :discipline_id, :education_id
    rename_table :resource_disciplines, :resource_educations
  end
end
