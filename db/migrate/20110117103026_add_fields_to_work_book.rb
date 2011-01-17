class AddFieldsToWorkBook < ActiveRecord::Migration
  def self.up
    add_column :work_books, :isbn,  :string
    add_column :work_books, :udk,   :string
    add_column :work_books, :bbk,   :string
    add_column :work_books, :kind,  :string
    add_column :work_books, :stamp, :string
  end

  def self.down
    remove_column :work_books, :isbn
    remove_column :work_books, :udk
    remove_column :work_books, :bbk
    remove_column :work_books, :kind
    remove_column :work_books, :stamp
  end
end

