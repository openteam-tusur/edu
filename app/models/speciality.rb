# encoding: utf-8

class Speciality < ActiveRecord::Base
  validates_presence_of :code, :degree, :name, :qualification

  default_scope order("degree, code")

  has_many :disciplines, :class_name => "Plan::Discipline", :dependent => :destroy

  has_many :curriculums, :class_name => "Plan::Curriculum", :dependent => :destroy
  has_many :chairs, :through => :curriculums

  has_one :licence, :class_name => "Plan::Licence", :dependent => :destroy
  accepts_nested_attributes_for :licence

  has_one :accreditation, :class_name => "Plan::Accreditation", :dependent => :destroy
  accepts_nested_attributes_for :accreditation

  protected_parent_of :curriculums, :protects => :softly

  has_enum :degree, %w[specialist master bachelor], :scopes => true

  searchable do
    text :info do
      chairs.map do |chair|
        "#{code} #{name} #{chair.abbr} #{chair.name}"
      end.join(" ")
    end

    integer :chair_id, :multiple => true, :references => Chair do
      chairs.map(&:id)
    end

    text :study do
      curriculums.published.map { |cur| "#{Plan::Curriculum.human_enum[:study][cur.study.to_sym]}"}.join(' ')
    end

    text :title

    string :degree
  end

  def self.search(query = nil, options = {})
    self.solr_search do
        keywords query unless query.blank?

        without :chair_id, nil

        chair_filter = with :chair_id, options[:chair_id] if options[:chair_id]
        degree_filter = with :degree, options[:degree] if options[:degree]

        facet :chair_id, :zeros => true, :exclude => chair_filter, :sort => :index
        facet :degree, :zeros => true, :exclude => degree_filter, :sort => :index
    end
  end

  def title
    "#{code} - #{name} (#{human_degree})"
  end

  def display_name
    title
  end

  def short_title
    "#{code} - #{name}"
  end

  def slug
    "#{self.code}-#{self.degree}"
  end

  def autocomplete_value
    value = "#{code}"
    chairs.each do |chair|
      value += " (#{chair.abbr})"
    end.join(" ")
    value += " - #{name}"
  end

  def to_param
    slug.gsub('.', '_')
  end

  def self.find_by_slug(slug)
    self.find_by_code_and_degree(*slug.split("-"))
  end

end

# == Schema Information
#
# Table name: specialities
# Human name: Специальность
#
#  id            :integer         not null, primary key
#  name          :string(255)     'Название'
#  degree        :string(255)     'Степень'
#  qualification :string(255)     'Квалификация'
#  created_at    :datetime
#  updated_at    :datetime
#  code          :string(255)     'Код'
#

