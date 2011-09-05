# encoding: utf-8

class Record < ActiveRecord::Base
  serialize :fields

  def title
    fields['002'] || fields['003']
  end

  def authors
    fields['001'].gsub(/%/, ', ').gsub(/~:u/, 'ü')
  end

end

