# encoding: utf-8

class Publication < Resource
  set_table_name :publications

  belongs_to  :chair

  has_many :resource_disciplines, :as => :resource
  has_many :authors, :as => :resource, :inverse_of => :resource
  accepts_nested_attributes_for :authors, :allow_destroy => true

  validates_presence_of :chair, :title, :attachment, :year, :access, :volume

  has_enum :kind, %w(tutorial lab_work course_work attestation practice seminar test demo work_programm)

  scope :published,   where(:state => 'published')
  scope :unpublished, where(:state => 'unpublished')
end


# == Schema Information
#
# Table name: publications
# Human name: Публикация
#
#  id         :integer         not null, primary key
#  chair_id   :integer
#  title      :string(255)     'Название'
#  year       :integer         'Год издания'
#  volume     :integer         'Количество страниц'
#  state      :string(255)     'Статус'
#  access     :string(255)     'Доступ к файлу'
#  kind       :string(255)     'Тип учебного материала'
#  isbn       :string(255)     'ISBN'
#  udk        :string(255)     'УДК'
#  bbk        :string(255)     'ББК'
#  stamp      :string(255)     'Гриф'
#  created_at :datetime
#  updated_at :datetime
#

