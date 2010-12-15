class CreateExaminations < ActiveRecord::Migration
  def self.up
    create_table :examinations do |t|
      t.string :slug
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :examinations
  end
end
