class Year < ActiveRecord::Base
  has_many :months, :order => 'title'
  validates_uniqueness_of :title
end

# == Schema Information
#
# Table name: years
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

