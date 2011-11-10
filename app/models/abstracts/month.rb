class Month < ActiveRecord::Base
  belongs_to :year
  validates_uniqueness_of :title
end

# == Schema Information
#
# Table name: months
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  year_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

