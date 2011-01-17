class CreateEducationResourceDisciplines < ActiveRecord::Migration
  def self.up
    create_table :educations_resource_disciplines, :id => false do |t|
      t.integer :education_id
      t.integer :resource_discipline_id
    end
  end

  def self.down
    drop_table :educations_resource_disciplines
  end
end
