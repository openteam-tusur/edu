# encoding: utf-8

class Record < ActiveRecord::Base
  serialize :fields

  belongs_to :issue

  def constants
    @constants ||= YAML::load(File.open("#{Rails.root}/config/abstracts.yml"))
  end

  def ololo
    @constants ||= YAML::load(File.open("#{Rails.root}/config/abstracts.yml"))["topic"]
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

