# encoding: utf-8

class PublicationDiscipline < ActiveRecord::Base

  belongs_to :publication
  belongs_to :discipline, :class_name => "Plan::Discipline"
  has_one :speciality, :through => :discipline

  has_and_belongs_to_many :educations, :class_name => "Plan::Education"


#  validates_presence_of :publication, :discipline
#  validates_uniqueness_of :discipline_id, :scope => :publication_id

  attr_accessor :speciality_request, :speciality_id, :discipline_request

  before_validation :validates_presence_of_educations

  searchable do
    string :kind do
      publication.kind
    end
    string :state do
      publication.state
    end
    integer :education_ids, :multiple => true do
      educations.map(&:id)
    end
  end

  def educations_grouped_by_curriculums(published = nil)
    grouped = {}
    curriculums = published ? speciality.curriculums.published : speciality.curriculums
    curriculums.where(:id => educations.map(&:curriculum)).each do |curriculum|
      grouped[curriculum] = curriculum.educations.where(:id => education_ids).all
    end
    grouped
  end

private

  def validates_presence_of_educations
    ids = self.education_ids & self.discipline.education_ids
    errors[:base] << "Необходимо выбрать семестры" if ids.empty?
  end

end


# == Schema Information
#
# Table name: publication_disciplines
#
#  id             :integer         not null, primary key
#  publication_id :integer
#  discipline_id  :integer
#  created_at     :datetime
#  updated_at     :datetime
#

