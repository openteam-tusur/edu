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
  has_many :publications,
           :through => :authors,
           :source => :resource,
           :source_type => "Publication"

  protected_parent_of :publications, :user

  searchable do
    text :autocomplete, :as => :autocomplete_textp do full_name end
    text :full_name
    integer :employee_chair_ids, :multiple => true do
      employees.accepted.map(&:chair_id)
    end
  end

  def self.available_authors(query)
    solr_search do
      keywords query
    end.results
  end

  def accepted_employee_in_chair(chair)
    employees.accepted.where(:chair_id => chair.id).first
  end

  def full_name
    "#{surname} #{name} #{patronymic}"
  end

  def abbreviated_name
    "#{surname} #{name[0...1]}. #{patronymic[0...1]}."
  end

  def full_name_with_posts
    "#{full_name}#{posts}"
  end

  def posts
    roles.accepted.empty? ? "": " — #{roles.accepted.map(&:to_s).join(', ')}"
  end

  def filled?
    !(surname.blank? || name.blank? || patronymic.blank?)
  end

  private

  def destroy_user
    self.user.destroy if self.user
  end

  def self.find_accepted_employees_in_chair(query, page, chair)
    solr_search do
      keywords query
      with :employee_chair_ids, chair.id
      paginate :page => page, :per_page => 10
    end.results
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

