class CreateSpecialityAccreditations < ActiveRecord::Migration
  def self.up
    create_table :speciality_accreditations do |t|
      t.integer :speciality_id
      t.string :number
      t.date :issued_at

      t.timestamps
    end
  end

  def self.down
    drop_table :speciality_accreditations
  end
end

