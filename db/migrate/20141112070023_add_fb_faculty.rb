#encoding: utf-8

class AddFbFaculty < ActiveRecord::Migration
  def self.up
    faculty = Faculty.create! :name => 'Факультет безопасности', :slug => 'fb', :abbr => 'ФБ'
    Chair.find_by_slug('kibevs').update_attributes! :faculty_id => faculty.id
    Chair.create! :name => 'Кафедра безопасности информационных систем', :abbr => 'БИС', :slug => 'bis', :faculty_id => faculty.id
  end

  def self.down
    Chair.find_by_slug('bis').destroy
    Chair.find_by_slug('kibevs').update_attributes! :faculty_id => Faculty.find_by_slug('fvs').id
    Faculty.find_by_slug('fb').destroy
  end
end
