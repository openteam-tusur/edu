class ResourceEducation < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true
  belongs_to :education, :class_name => "Plan::Education"
  validates_presence_of :resource, :education
  validates_uniqueness_of :education_id, :scope => [:resource_type, :resource_id]
end

# == Schema Information
#
# Table name: resource_educations
#
#  id            :integer         not null, primary key
#  resource_id   :integer
#  resource_type :string(255)
#  education_id  :integer
#  created_at    :datetime
#  updated_at    :datetime
#

