class Human < ActiveRecord::Base

  default_scope order('surname')

  attr_accessor :post, :chair_id

  belongs_to :user

  has_many :roles

  def filled?
    !(surname.blank? || name.blank? || patronymic.blank?)
  end

  has_many :students, :class_name => 'Roles::Student'
  has_many :teachers, :class_name => 'Roles::Teacher'

  validates_presence_of :post, :if => :chair_id

  def accepted_teacher_in_chair(chair)
    teachers.accepted.where(:chair_id => chair.id).first
  end

end

# == Schema Information
#
# Table name: humans
# Human name: Персональная информация
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  surname    :string(255)     'Фамилия'
#  name       :string(255)     'Имя'
#  patronymic :string(255)     'Отчество'
#  created_at :datetime
#  updated_at :datetime
#

