class MainSubject < ActiveRecord::Base
  has_many :subjects
end

# == Schema Information
#
# Table name: main_subjects
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  key        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

