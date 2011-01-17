class ResourceDiscipline < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true
  belongs_to :discipline, :class_name => "Plan::Discipline"
  delegate :speciality, :to => :discipline

  validates_presence_of :resource, :discipline
  validates_uniqueness_of :discipline_id, :scope => [:resource_type, :resource_id]

  attr_accessor :speciality_request
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

