class CreateEducationExaminations < ActiveRecord::Migration
  def self.up
    create_table :educations_examinations, :id => false do |t|
      t.integer :education_id
      t.integer :examination_id
      t.timestamps
    end

  end

  def self.down
    drop_table :educations_examinations
  end
end
