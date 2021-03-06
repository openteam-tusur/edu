# encoding: utf-8

class Faculty < ActiveRecord::Base
  has_many :chairs
  default_scope order('id')
  validates_presence_of :name, :abbr, :slug
  validates_uniqueness_of :abbr, :slug, :name
end


# == Schema Information
#
# Table name: faculties
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  abbr       :string(255)
#  slug       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

