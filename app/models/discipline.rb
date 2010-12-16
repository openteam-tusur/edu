class Discipline < ActiveRecord::Base
  belongs_to :speciality
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :speciality_id
end
