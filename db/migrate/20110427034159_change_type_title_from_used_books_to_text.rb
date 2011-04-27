class ChangeTypeTitleFromUsedBooksToText < ActiveRecord::Migration
  def self.up
    change_column :used_books, :title, :text
  end

  def self.down
    change_column :used_books, :title, :string
  end
end
