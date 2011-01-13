class ResourceEducation < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true
  belongs_to :education, :class_name => "Plan::Education"
  validates_presence_of :resource, :education
  validates_uniqueness_of :education_id, :scope => [:resource_type, :resource_id]
end
