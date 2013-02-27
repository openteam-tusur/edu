# encoding: utf-8

class Publication < Resource
  set_table_name :publications

  belongs_to  :chair

  has_many :publication_disciplines, :dependent => :destroy,
                                     :include => :discipline,
                                     :order => 'disciplines.name'
  has_many :disciplines, :through => :publication_disciplines

  has_many :used_books

  has_many :authors, :as => :resource, :inverse_of => :resource
  accepts_nested_attributes_for :authors, :allow_destroy => true

  accepts_nested_attributes_for :used_books, :allow_destroy => true, :reject_if => :all_blank

  validates_presence_of :chair, :title, :attachment, :year,
                        :access, :volume, :kind, :extended_kind

  after_save :reindex_publication_disciplines

  has_enum :kind, %w(tutorial training_toolkit work_programm), :scopes => true

  scope :published,   where(:state => 'published')
  scope :unpublished, where(:state => 'unpublished')

  delegate :abbr, :to => :chair, :prefix => true

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

    text :license_number
    time :updated_at
    text :extended_kind

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

      paginate :page => options[:page], :per_page => options[:per_page] || Publication.per_page

      unless query && options.empty?
        order_by :updated_at, :desc
      end
    end
  end

  def published?
    self.state.eql?("published")
  end

  def grouped_disciplines
    result = {}
    publication_disciplines.each do |publication_discipline|
      result[publication_discipline.speciality] ||= []
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

  def author_names(format = :full_name)
    authors.map(&:human).map(&format).join(", ")
  end

  def to_s
    result = "#{title}: #{get_extended_kind} / "
    result += authors.empty? ? "" : "#{author_names(:abbreviated_name)} – "
    result += "#{year}. #{volume} с."
  end

  def kind_abbr
    human_kind.mb_chars.split(/[\s-]/).map(&:first).join.mb_chars.upcase.to_s
  end

  def license_number
    "#{kind_abbr}-#{id}"
  end

  def to_report
    builder = Nokogiri::XML::Builder.new(:encoding => 'utf-8') do |xml|
      xml.root do
        xml.parent.name = "doc"
        xml.number license_number
        xml.year Time.now.year
        xml.licensor author_names
        xml.publication to_s

        xml.authors do |xml_authors|
          authors.map(&:human).each do |human|
            xml.author do
              xml.name human.abbreviated_name
              xml.roles human.roles.where(:chair_id => chair.id).accepted.map(&:to_s).join(', ')
            end
          end
        end
      end
    end
    builder.to_xml
  end

  def self.roster_data
    builder = Nokogiri::XML::Builder.new(:encoding => 'utf-8') do |xml|
      xml.root do
        xml.parent.name = 'doc'

        %w(tutorial training_toolkit).each do |kind|
          xml.send kind.pluralize do
            self.send("kind_#{kind}").published.order('id DESC').each do |publication|
              xml.send kind do
                xml.id          publication.id
                xml.title       publication.title
                xml.chair_abbr  publication.chair_abbr
                xml.authors     publication.author_names(:abbreviated_name)
                xml.year        publication.year
                xml.volume      publication.volume
                xml.stamp       publication.stamp
                xml.access      publication.access_free? ? 'Свободный' : 'Ограниченный'
                xml.isbn        publication.isbn
                xml.udk         publication.udk
                xml.bbk         publication.bbk
              end
            end
          end
        end
      end
    end

    builder.to_xml
  end

  def self.generate_data(template, data)
    template_name, template_ext = template.split('.')

    template_path = Rails.root.join("reports", template).to_s
    result_data = ""

    Tempfile.open ["data_file", ".xml"] do |data_file|
      data_file << data
      data_file.flush

      Tempfile.open [template_name, ".#{template_ext}"] do |file|
        libdir = Rails.root.join "reports", "lib"
        result = system("java", "-Djava.ext.dir=#{libdir}", "-jar", "#{libdir}/jodreports-2.1-RC.jar", template_path, data_file.path, file.path)
        raise "Ошибка создания документа" unless result

        result_data = File.read(file.path)
      end
    end
    result_data
  end

  private
    def reindex_publication_disciplines
      PublicationDiscipline.reindex
    end

end



# == Schema Information
#
# Table name: publications
#
#  id            :integer         not null, primary key
#  chair_id      :integer
#  title         :string(255)
#  year          :integer
#  volume        :integer
#  state         :string(255)
#  access        :string(255)
#  kind          :string(255)
#  isbn          :string(255)
#  udk           :string(255)
#  bbk           :string(255)
#  stamp         :text
#  created_at    :datetime
#  updated_at    :datetime
#  content       :text
#  annotation    :text
#  extended_kind :string(255)
#  comment       :text
#

