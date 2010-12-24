class Chair < ActiveRecord::Base
  belongs_to :faculty

  has_many :specialities

  validates_presence_of :name, :abbr, :slug
  validates_uniqueness_of :slug, :abbr, :name

  has_many :accepted_roles_teachers, :class_name => 'Roles::Teacher', :conditions => {:state => "accepted"}
  has_many :teachers, :class_name => "Human", :through => :accepted_roles_teachers, :source => :human

  has_many :work_programms

  default_scope order("id")

  def to_param
    self.slug
  end

  def self_with_abbr
    "#{self.name} (#{self.abbr})"
  end

  def create_teacher(params)
    human = Human.new(params.merge(:chair_id => self.id))
    if human.save
      teacher = human.teachers.create!(:post => human.post, :chair_id => self.id)
      teacher.accept!
    end
    human
  end

  def find_teacher(human_id)
    teacher = Human.find(human_id)
    teacher_role = teacher.accepted_teacher_in_chair(self)
    raise ActiveRecord::RecordNotFound unless teacher_role
    teacher.post = teacher_role.post
    teacher.chair_id = self.id
    teacher
  end

  def update_teacher(human_id, params)
    teacher = find_teacher(human_id)
    teacher.accepted_teacher_in_chair(self).update_attribute(:post, params["post"]) if teacher.update_attributes(params)
    teacher
  end
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

