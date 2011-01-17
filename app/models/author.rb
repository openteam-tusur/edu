class Author < ActiveRecord::Base
  attr_accessor :author_query
  belongs_to :resource, :polymorphic => true
  belongs_to :human
  validates_presence_of :resource, :human
  validates_uniqueness_of :human_id, :scope => [:resource_id, :resource_type]
end

# == Schema Information
#
# Table name: authors
# Human name: Автор материала
#
#  id            :integer         not null, primary key
#  resource_id   :integer
#  resource_type :string(255)
#  human_id      :integer         'Автор'
#  created_at    :datetime
#  updated_at    :datetime
#

