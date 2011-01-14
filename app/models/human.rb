# encoding: utf-8

class Human < ActiveRecord::Base

  default_scope order('surname, name, patronymic')

  attr_accessor :post, :chair_id, :human_id

  belongs_to :user

  has_many :roles, :dependent => :destroy
  after_destroy :destroy_user

  has_many :students, :class_name => 'Roles::Student'
  has_many :employees, :class_name => 'Roles::Employee'

  validates_presence_of :post, :surname, :name, :patronymic,  :if => :chair_id
  validates_presence_of :human_id,
                        :if => :chair_id,
                        :on => :create,
                        :message => 'Необходимо выполнить проверку перед добавлением сотрудника или\
                                     должности и выбрать действие'

  has_many :authors
  has_many :work_programms,
           :through => :authors,
           :source => :resource,
           :source_type => "WorkProgramm"

  protected_parent_of :work_programms

  searchable do
    text :full_name
  end

  def self.available_authors(query, options = {})
    solr_search do
      text_fields do
        query.split(/[^[:alnum:]]+/).each do | term |
          with(:full_name).starting_with term
        end
      end
      without options[:without] if options[:without]
    end.results
  end

  def accepted_employee_in_chair(chair)
    employees.accepted.where(:chair_id => chair.id).first
  end

  def full_name
    "#{surname} #{name} #{patronymic}"
  end

  def filled?
    !(surname.blank? || name.blank? || patronymic.blank?)
  end

  private

  def destroy_user
    self.user.destroy if self.user
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

