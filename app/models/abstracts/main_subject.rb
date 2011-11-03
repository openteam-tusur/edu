class MainSubject < ActiveRecord::Base
  has_many :subjects
  validates_presence_of :title, :code
  validates_uniqueness_of :code
end


# == Schema Information
#
# Table name: main_subjects
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  code       :string(255)
#

