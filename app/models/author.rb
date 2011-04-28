class Author < ActiveRecord::Base
  attr_accessor :author_query
  belongs_to :resource, :polymorphic => true
  belongs_to :human
  delegate :abbreviated_name, :to => :human
  validates_presence_of :resource, :human
  validates_uniqueness_of :human_id, :scope => [:resource_id, :resource_type]
end


# == Schema Information
#
# Table name: authors
#
#  id            :integer         not null, primary key
#  resource_id   :integer
#  resource_type :string(255)
#  human_id      :integer
#  created_at    :datetime
#  updated_at    :datetime
#

