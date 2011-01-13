class Chair < ActiveRecord::Base

  belongs_to :faculty

  has_many :specialities

  validates_presence_of :name, :abbr, :slug
  validates_uniqueness_of :slug, :abbr, :name

  has_many :accepted_roles_employees, :class_name => 'Roles::Employee', :conditions => {:state => "accepted"}
  has_many :employees, :class_name => "Human", :through => :accepted_roles_employees, :source => :human

  has_many :work_programms

  default_scope order("id")

  def to_param
    self.slug
  end

  def self_with_abbr
    "#{self.name} (#{self.abbr})"
  end

  def create_employee(params)
    human = Human.new(params.merge(:chair_id => self.id))
    return human unless human.valid?
    if human.human_id.blank?
      if human.save
        teacher = human.employees.create!(:post => human.post, :chair_id => self.id)
        teacher.accept!
      end
    else
      existed_human = Human.find(human.human_id)
      teacher = existed_human.employees.create!(:post => human.post, :chair_id => self.id)
      teacher.accept!
      return existed_human
    end
    human
  end

  def find_employee(human_id)
    employee = Human.find(human_id)
    employee_role = employee.accepted_employee_in_chair(self)
    raise ActiveRecord::RecordNotFound unless employee_role
    employee.post = employee_role.post
    employee.chair_id = self.id
    employee
  end

  def update_employee(human_id, params)
    employee = find_employee(human_id)
    employee.accepted_employee_in_chair(self).update_attribute(:post, params["post"]) if employee.update_attributes(params)
    employee
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

