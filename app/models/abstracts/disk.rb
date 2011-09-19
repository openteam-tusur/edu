class Disk < ActiveRecord::Base

  has_many :issues

end

# == Schema Information
#
# Table name: disks
#
#  id         :integer         not null, primary key
#  year       :string(255)
#  month      :string(255)
#  disk_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

