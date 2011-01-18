class AddFieldsToPublication < ActiveRecord::Migration
  def self.up
    change_column :publications, :stamp, :text
    add_column :publications, :content, :text
    add_column :publications, :annotation, :text
  end

  def self.down
    change_column :publications, :stamp, :string
    remove_column :publications, :content
    remove_column :publications, :annotation
  end
end
