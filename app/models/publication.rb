# encoding: utf-8

class Publication < Resource
  set_table_name :publications

  belongs_to  :chair

  has_many :publication_disciplines
  has_many :authors, :as => :resource, :inverse_of => :resource
  accepts_nested_attributes_for :authors, :allow_destroy => true

  validates_presence_of :chair, :title, :attachment, :year, :access, :volume, :kind

  has_enum :kind, %w(work_programm tutorial lab_work course_work attestation practice seminar test demo)

  scope :published,   where(:state => 'published')
  scope :unpublished, where(:state => 'unpublished')

  searchable do
    text :title
    text :year

    text :authors do
      authors.map(&:human).map(&:full_name).join(" ")
    end

    integer :chair_id

    string :kind
  end

  def self.search(query, chair, options={})
    solr_search do
      keywords query unless query.blank?
      with :chair_id, chair.id
      kind_filter = with :kind, options[:kind] if options[:kind]
      facet :kind, :zeros => true, :exclude => kind_filter
      paginate :page => options[:page], :per_page => Publication.per_page
    end
  end
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

