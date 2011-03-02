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

  validates_presence_of :chair, :title, :attachment, :year,
                        :access, :volume, :kind, :extended_kind

  after_save :reindex_publication_disciplines

  has_enum :kind, %w(training_toolkit tutorial work_programm), scopes:true

  scope :published,   where(:state => 'published')
  scope :unpublished, where(:state => 'unpublished')

  searchable do
    text :title
    text :year

    text :authors do
      authors.map(&:human).map(&:full_name).join(" ")
    end

    integer :chair_id, :references => Chair

    string :state

    string :kind
    string :state

    boolean :with_comment do
      !comment.blank?
    end
  end

  def self.search(query = nil, chair = nil, options = {}, published = nil)
    solr_search do
      keywords query unless query.blank?

      kind_filter = with :kind, options[:kind] if options[:kind]
      chair_filter = with :chair_id, options[:chair_id] if options[:chair_id]
      with :state, 'published' if published

      state_filter = with :state, options[:state] if options[:state]
      condition = options[:with_comment].blank? ? false : true
      comment_filter = with :with_comment, condition if condition

      facet :kind, :zeros => true, :exclude => kind_filter, :sort => :index
      facet :chair_id, :zeros => true, :exclude => chair_filter, :sort => :index
      facet :state, :zeros => true, :exclude => state_filter, :sort => :index
      facet :with_comment, :zeros => true, :exclude => comment_filter, :sort => :index

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
    if kind.eql? 'work_programm'
      return [:annotation]
    end

    if kind.eql? 'tutorial'
      return [:annotation, :content, :bbk, :isbn, :udk, :stamp]
    end

    if kind.eql? 'training_toolkit'
     return [:annotation, :content, :udk]
    end
  end

  def addition_fields(kind = self.kind)
    if kind.eql? 'work_programm'
      return [:annotation]
    end

    if kind.eql? 'tutorial'
      return [:stamp, :annotation, :bbk, :isbn, :udk]
    end

    if kind.eql? 'training_toolkit'
     return [:udk, :annotation]
    end
  end

  def get_extended_kind
    extended_kind.gsub(/^./) { |symbol| symbol.mb_chars.upcase}
  end

  def to_s
    result = "#{title}: #{get_extended_kind} / "
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

  def generate_data
    template_path = Rails.root.join("reports", "publication.odt").to_s
    result_data = ""

    Tempfile.open ["data_file", ".xml"] do |data_file|
      data_file << to_report
      data_file.flush

      Tempfile.open ["publication", ".odt"] do | odt_file |
        libdir = Rails.root.join "reports", "lib"
        result = system("java", "-Djava.ext.dir=#{libdir}", "-jar", "#{libdir}/jodreports-2.1-RC.jar", template_path, data_file.path, odt_file.path)
        raise "Ошибка создания документа" unless result

        result_data = File.read(odt_file.path)
      end
    end
    result_data
  end

  class_eval do
    self.enum(:kind).each do |kind|
      scope kind.to_sym, where(:kind => kind)
    end
  end

  private
    def reindex_publication_disciplines
      PublicationDiscipline.reindex
    end

end


# == Schema Information
#
# Table name: publications
# Human name: Учебно-методический материал
#
#  id            :integer         not null, primary key
#  chair_id      :integer
#  title         :string(255)     'Название'
#  year          :integer         'Год издания'
#  volume        :integer         'Количество страниц'
#  state         :string(255)     'Статус'
#  access        :string(255)     'Доступ к файлу'
#  kind          :string(255)     'Тип учебного материала'
#  isbn          :string(255)     'ISBN'
#  udk           :string(255)     'УДК'
#  bbk           :string(255)     'ББК'
#  stamp         :text            'Гриф'
#  created_at    :datetime
#  updated_at    :datetime
#  content       :text            'Содержание'
#  annotation    :text            'Описание'
#  extended_kind :string(255)     'Полное название типа материала'
#  comment       :text            'Примечание'
#

