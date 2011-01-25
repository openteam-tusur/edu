# encoding: utf-8

class Publication < Resource
  set_table_name :publications

  belongs_to  :chair

  has_many :publication_disciplines, :dependent => :destroy,
    :include => :discipline,
    :order => "plan_disciplines.name"
  has_many :disciplines, :through => :publication_disciplines

  has_many :authors, :as => :resource, :inverse_of => :resource
  accepts_nested_attributes_for :authors, :allow_destroy => true

  validates_presence_of :chair, :title, :attachment, :year, :access, :volume, :kind

  has_enum :kind, %w(work_programm tutorial lab_work course_work attestation practice seminar test demo independent)

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

  def grouped_disciplines
    result = {}
    Speciality.where(:id => self.disciplines.map(&:speciality_id)).each do |spec|
      result[spec] = []
    end
    publication_disciplines.each do |publication_discipline|
      result[publication_discipline.speciality] << publication_discipline
    end
    result
  end

  def fields_for_kind(kind = self.kind)
    if %w(work_programm demo).include? kind
      return [:annotation]
    end

    if %w(tutorial).include? kind
      return [:bbk, :isbn, :udk, :annotation, :content, :stamp]
    end

    if %w(lab_work course_work attestation practice seminar test independent).include? kind
     return [:annotation, :content]
    end
  end

  def to_s
    result = "#{title}: #{human_kind} / "
    result += authors.empty? ? "" : "#{authors.map(&:abbreviated_name).join(', ')} – "
    result += "#{year}. #{volume} с."
  end

  def to_report
    builder = Nokogiri::XML::Builder.new(:encoding => 'utf-8') do |xml|
      xml.root do
        xml.parent.name = "doc"
        xml.licensor authors.map(&:human).map(&:full_name).join(", ")
        xml.publication to_s
        xml.authors do |xml_authors|
          authors.map(&:human).map(&:abbreviated_name).each do |author|
            xml_authors.author author
          end
        end
      end
    end
    builder.to_xml
  end

end


# == Schema Information
#
# Table name: publications
# Human name: Учебно-методический материал
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
#  stamp      :text            'Гриф'
#  created_at :datetime
#  updated_at :datetime
#  content    :text            'Содержание'
#  annotation :text            'Описание'
#

