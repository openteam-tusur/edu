# encoding: utf-8

class Record < ActiveRecord::Base
  serialize :fields

  belongs_to :issue

  delegate :year, :month, :to => :issue

  searchable do
    text :id, :boost => 2
    text :main_subject, :year, :updated_month, :subject, :short_title, :authors
    time :updated_at
    string :main_subject
    string :subject
    string :year
    string :updated_month
  end

  def self.search(params)
    solr_search do
      fulltext params[:search]
      facet(:updated_month)
      facet(:main_subject)
      facet(:subject)
      with(:updated_month, params[:month]) if params[:month].present?
      with(:main_subject, params[:main_subject]) if params[:main_subject].present?
      with(:subject, params[:subject]) if params[:subject].present?
      with(:updated_month, params[:year]) if params[:year].present?
      paginate :page => params[:page], :per_page => 10
    end
  end

  def updated_month
    updated_at = [year, month].join " "
  end

  def constants
    @constants ||= YAML::load(File.open("#{Rails.root}/config/abstracts.yml"))
  end

  def authors
    fields['001']
  end

  def short_title
    fields['002'] || fields['003']
  end

  def language
    fields['004']
  end

  def reflection_abstracts_service
    fields['005']
  end

  def keyword
    fields['006']
  end

  def publication_date
    fields['007']
  end

  def title
    fields['021']
  end

  def view_document
    fields['035']
  end

  def code_column_VINITI
    fields['036']
  end

  def country
    fields['042']
  end

  def pagination
    fields['043']
  end

  def serial_number
    fields['076']
  end

  def summary
    fields['100']
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

# Field for the formation of the structure of the form

  def main_subject
    constants["topic"][fields['514'][0..1]]
  end

  def subject
    constants["topic"][fields['501']]
  end

  def year
    fields['514'][2..5]
  end

  def month
    fields['507']
  end

  def tipe
    constants["codes_documents"][fields["035"]]
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
#

