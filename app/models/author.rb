class Author < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true
  belongs_to :human
  validates_presence_of :resource, :human
  validates_uniqueness_of :human_id, :scope => [:resource_id, :resource_type]
end
