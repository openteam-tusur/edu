# encoding: utf-8

class Human < ActiveRecord::Base

  default_scope order('surname')

  attr_accessor :post, :chair_id, :human_id

  belongs_to :user

  has_many :roles

  def filled?
    !(surname.blank? || name.blank? || patronymic.blank?)
  end

  has_many :students, :class_name => 'Roles::Student'
  has_many :employees, :class_name => 'Roles::Employee'

  validates_presence_of :post, :surname, :name, :patronymic,  :if => :chair_id
  validates_presence_of :human_id, :if => :chair_id, :message => 'Необходимо выполнить проверку перед добавлением сотрудника или должности и выбрать действие'

  def accepted_employee_in_chair(chair)
    employees.accepted.where(:chair_id => chair.id).first
  end

  def full_name
    "#{surname} #{name} #{patronymic}"
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

