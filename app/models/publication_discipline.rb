# encoding: utf-8

class PublicationDiscipline < ActiveRecord::Base

  belongs_to :publication
  belongs_to :discipline, :class_name => "Plan::Discipline"
  delegate :speciality, :to => :discipline

  has_and_belongs_to_many :educations, :class_name => "Plan::Education"

  validates_presence_of :publication, :discipline
  validates_uniqueness_of :discipline_id, :scope => :publication_id

  attr_accessor :speciality_request, :speciality_id, :discipline_request

  before_validation :validate_exists_of_educations

private

  def validate_exists_of_educations
    errors[:base] << "Необходимо выбрать семестры" if education_ids.empty?
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

