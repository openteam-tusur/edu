# encoding: utf-8

class Record < ActiveRecord::Base
  serialize :fields

  def authors
    fields['001'].gsub(/%/, ', ').gsub(/~:u/, 'ü')
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

end

