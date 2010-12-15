class Chair < ActiveRecord::Base
  belongs_to :faculty
end

# == Schema Information
#
# Table name: chairs
#
#  id         :integer         not null, primary key
#  faculty_id :integer
#  name       :string(255)
#  abbr       :string(255)
#  slug       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

