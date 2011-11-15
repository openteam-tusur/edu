# encoding: utf-8

class Record < ActiveRecord::Base
  serialize :fields

  belongs_to :issue
  belongs_to :subject
  belongs_to :month

  delegate :main_subject, :to => :subject
  delegate :year, :to => :month

  before_save :associate_subject, :associate_month

  def self.subjects_dictionary
    @subjects_dictionary ||= YAML.load_file(Rails.root.join('config', 'abstracts', 'subjects.yml'))
  end

  def self.document_codes
    @document_codes ||= YAML.load_file(Rails.root.join('config', 'abstracts', 'document_codes.yml'))
  end

  searchable do
    text :title, :authors, :keywords, :summary
    integer :year_id do
      year.id
    end
    integer :month_id
    integer :main_subject_id do
      main_subject.id
    end
    integer :subject_id
  end



  def self.search(params)
    solr_search do
      fulltext params[:search]
      all_of do
        with(:main_subject_id, params[:main_subject]) if params[:main_subject]
        with(:subject_id, params[:subject]) if params[:subject]
      end
      all_of do
        with(:year_id, params[:year]) if params[:year]
        with(:month_id, params[:month]) if params[:month]
      end
      paginate :page => params[:page], :per_page => 10
    end
  end

  def authors
    fields['001']
  end

  def keywords
    fields['006']
  end

  def title
    fields['021']
  end

  def language
    fields['004']
  end

  def reflection_abstracts_service
    fields['005']
  end

  def publication_date
    fields['007']
  end

  def short_title
    fields['021']
  end

  def view_document
    fields['035']
  end

  def code_column_VINITI
    fields['036']
  end

  def country
    fields['040']
  end

  def pagination
    fields['043']
  end

  def serial_number
    fields['076']
  end

  def code_database
    fields['501']
  end

  def codes_colomn_SRSTI
    fields['504']
  end

  def number_AJ_DB
    fields['507']
  end

  def code_thematic
    fields['514']
  end

  def codes_colomn_SRSTI
    fields['504']
  end

  def summary
    fields['100']
  end

  def main_subject_code
    fields['501'][0..1]
  end

  def subject_code
    fields['501']
  end

  def year_title
    fields['514'][2..5]
  end

  def month_title
    fields['507']
  end


  def tipe
    self.class.document_codes[fields["035"]]
  end

  private

    def associate_subject
      subject = Subject.find_or_initialize_by_code(self.subject_code)
      main_subject = MainSubject.find_or_initialize_by_code(self.main_subject_code)
      main_subject.update_attribute(:title, self.class.subjects_dictionary[main_subject.code])
      subject.update_attributes(:title => self.class.subjects_dictionary[subject.code], :main_subject => main_subject)
      self.subject = subject
    end

    def associate_month
      year = Year.find_or_create_by_title(year_title)
      month = year.months.find_or_create_by_title(month_title)
      self.month = month
    end

end




# == Schema Information
#
# Table name: records
#
#  id         :integer         not null, primary key
#  fields     :text
#  created_at :datetime
#  updated_at :datetime
#  issue_id   :integer
#  subject_id :integer
#  month_id   :integer
#

