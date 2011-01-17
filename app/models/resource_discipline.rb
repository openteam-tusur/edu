# encoding: utf-8

class ResourceDiscipline < ActiveRecord::Base

  belongs_to :resource, :polymorphic => true
  belongs_to :discipline, :class_name => "Plan::Discipline"
  delegate :speciality, :to => :discipline

  has_and_belongs_to_many :educations, :class_name => "Plan::Education"

  validates_presence_of :resource, :discipline
  validates_uniqueness_of :discipline_id, :scope => [:resource_type, :resource_id]

  attr_accessor :speciality_request

  before_validation :validate_presence_of_educations

private

  def validate_presence_of_educations
    errors[:base] << "Необходимо выбрать семестры" if education_ids.empty?
  end

end

# == Schema Information
#
# Table name: resource_disciplines
#
#  id            :integer         not null, primary key
#  resource_id   :integer
#  resource_type :string(255)
#  discipline_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

