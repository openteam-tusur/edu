class MainSubject < ActiveRecord::Base
  has_many :subjects, :order => 'title'
  validates_presence_of :title, :code
  validates_uniqueness_of :code
  
  def all_subjects_checked?(subject_ids)
    (subjects.map(&:id).map(&:to_s) - subject_ids).empty?
  end
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

