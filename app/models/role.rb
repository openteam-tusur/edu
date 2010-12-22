class Role < ActiveRecord::Base
  belongs_to :human
end

# == Schema Information
#
# Table name: roles
#
#  id         :integer         not null, primary key
#  human_id   :integer
#  title      :string(255)
#  slug       :string(255)     'Слаг'
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

