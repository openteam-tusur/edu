class CreateWorkBooks < ActiveRecord::Migration
  def self.up
    create_table :work_books do |t|
      t.string :title
      t.integer :year
      t.integer :volume
      t.string :state
      t.string :access
      t.integer :chair_id

      t.timestamps
    end
  end

  def self.down
    drop_table :work_books
  end
end

