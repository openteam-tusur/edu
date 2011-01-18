class RenameResourceDisciplineToPublicationDiscipline < ActiveRecord::Migration
  def self.up
    rename_column :resource_disciplines, :resource_id, :publication_id
    remove_column :resource_disciplines, :resource_type
    rename_table :resource_disciplines, :publication_disciplines
  end

  def self.down
    rename_table :publication_disciplines, :resource_disciplines
    rename_column :resource_disciplines, :publication_id, :resource_id
    add_column :resource_disciplines, :resource_type, :string
  end
end
