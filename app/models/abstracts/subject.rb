class Subject < ActiveRecord::Base
  belongs_to :main_subject
  validates_presence_of :title, :code
  validates_uniqueness_of :code
end


# == Schema Information
#
# Table name: subjects
#
#  id              :integer         not null, primary key
#  code            :string(255)
#  title           :string(255)
#  main_subject_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#

