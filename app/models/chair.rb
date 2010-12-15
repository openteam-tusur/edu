class Chair < ActiveRecord::Base
  belongs_to :faculty

  has_many :specialities

  validates_uniqueness_of :slug

  default_scope order("id")

  def to_param
    self.slug
  end
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

