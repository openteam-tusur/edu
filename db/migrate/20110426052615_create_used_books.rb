class CreateUsedBooks < ActiveRecord::Migration
  def self.up
    create_table :used_books do |t|
      t.string :title
      t.string :kind
      t.integer :publication_id
      t.string :library_code
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :used_books
  end
end
