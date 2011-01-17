class ChangeFieldInWorkBook < ActiveRecord::Migration
  def self.up
    change_column :work_books, :title, :text
    change_column :work_books, :stamp, :text
  end

  def self.down
    change_column :work_books, :title, :string
    change_column :work_books, :stamp, :string
  end
end
