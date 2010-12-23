class Human < ActiveRecord::Base
  belongs_to :user

  has_many :roles

  def filled?
    !(surname.blank? || name.blank? || patronymic.blank?)
  end

  has_many :students, :class_name => 'Roles::Student'
  has_many :teachers, :class_name => 'Roles::Teacher'
  accepts_nested_attributes_for :students, :teachers
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

