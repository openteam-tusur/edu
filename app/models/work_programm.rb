# encoding: utf-8
class WorkProgramm < Resource
  set_table_name :work_programms

  belongs_to  :chair
  has_many    :resource_disciplines, :as => :resource
  has_many    :authors, :as => :resource
  accepts_nested_attributes_for :authors

  validates_presence_of :chair, :title, :attachment, :year, :access, :resource_name
  default_values :resource_name => "Рабочая программа"

  scope :published,   where(:state => 'published')
  scope :unpublished, where(:state => 'unpublished')

  def authors_list
    authors.map(&:human).map(&:initials).join(', ')
  end
end

# == Schema Information
#
# Table name: work_programms
# Human name: Рабочая программа
#
#  id            :integer         not null, primary key
#  chair_id      :integer
#  year          :integer         'Год издания'
#  state         :string(255)     'Статус'
#  access        :string(255)     'Доступ к файлу'
#  resource_name :text            'Название файла'
#  created_at    :datetime
#  updated_at    :datetime
#  title         :text            'Название'
#

