# encoding: utf-8

class Study < ActiveRecord::Base
  set_table_name :studies

  belongs_to :chair
  belongs_to :curriculum
  has_one :speciality, :through => :curriculum
  belongs_to :discipline
  belongs_to :cycle

  has_many :educations, :dependent => :destroy
  has_many :semesters, :through => :educations

  attr_accessor :discipline_name

  validates_presence_of :chair, :discipline_name, :curriculum, :cycle_id
  validates_uniqueness_of :discipline_id, :scope => :curriculum_id

  before_validation :prepare_discipline
  accepts_nested_attributes_for :educations, :allow_destroy => true, :reject_if => proc { |attributes| attributes['semester_id'].blank? }

  protected_parent_of :publications, :protects => :softly

  def title
    discipline.name
  end

  def publications
    educations.map(&:publication_disciplines).flatten.uniq.map(&:publication).uniq
  end

  private

    def prepare_discipline
      return if discipline_name.blank?
      old_discipline = self.discipline
      new_discipline = curriculum.speciality.disciplines.find_or_create_by_name(discipline_name)
      self.discipline_id = new_discipline.id
      return unless old_discipline
      return if old_discipline.eql?(new_discipline)
      old_discipline.destroy if old_discipline.studies.eql? [self]
    end
end



# == Schema Information
#
# Table name: studies
#
#  id            :integer         not null, primary key
#  chair_id      :integer
#  curriculum_id :integer
#  discipline_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#  cycle_id      :integer
#

