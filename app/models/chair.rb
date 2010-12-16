class Chair < ActiveRecord::Base
  belongs_to :faculty

  has_many :specialities

  validates_uniqueness_of :slug

  default_scope order("id")

#  def to_param
#    self.slug
#  end
end

# == Schema Information
#
# Table name: chairs
# Human name: Кафедра
#
#  id         :integer         not null, primary key
#  faculty_id :integer
#  name       :string(255)     'Название'
#  abbr       :string(255)     'Аббревиатура'
#  slug       :string(255)     'Слаг'
#  created_at :datetime
#  updated_at :datetime
#

