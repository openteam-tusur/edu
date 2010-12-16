class CreateSpecialitySemesters < ActiveRecord::Migration
  def self.up
    create_table :speciality_semesters do |t|
      t.integer :speciality_id
      t.integer :number

      t.timestamps
    end
  end

  def self.down
    drop_table :speciality_semesters
  end
end

