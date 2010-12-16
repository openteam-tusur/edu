class CreateSpecialityEducations < ActiveRecord::Migration
  def self.up
    create_table :speciality_educations do |t|
      t.references :speciality_semester
      t.references :speciality_discipline
      t.integer :loading_lecture
      t.integer :loading_laboratory
      t.integer :loading_practice
      t.integer :loading_course_project
      t.integer :loading_course_work
      t.integer :loading_self_training

      t.timestamps
    end
  end

  def self.down
    drop_table :speciality_educations
  end
end
