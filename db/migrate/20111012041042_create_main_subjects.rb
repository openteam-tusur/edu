class CreateMainSubjects < ActiveRecord::Migration
  def self.up
    create_table :main_subjects do |t|
      t.string :title
      t.string :key

      t.timestamps
    end
  end

  def self.down
    drop_table :main_subjects
  end
end

