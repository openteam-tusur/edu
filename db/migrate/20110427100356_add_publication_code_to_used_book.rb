class AddPublicationCodeToUsedBook < ActiveRecord::Migration
  def self.up
    add_column :used_books, :publication_code, :integer
  end

  def self.down
    remove_column :used_books, :publication_code
  end
end
