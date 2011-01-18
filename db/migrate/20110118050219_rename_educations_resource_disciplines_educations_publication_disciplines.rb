class RenameEducationsResourceDisciplinesEducationsPublicationDisciplines < ActiveRecord::Migration
  def self.up
    rename_table :educations_resource_disciplines, :educations_publication_disciplines
    rename_column :educations_publication_disciplines, :resource_discipline_id, :publication_discipline_id
  end

  def self.down
    rename_column :educations_publication_disciplines, :publication_discipline_id, :resource_discipline_id
    rename_table :educations_publication_disciplines, :educations_resource_disciplines
  end
end
