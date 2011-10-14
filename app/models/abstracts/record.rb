# encoding: utf-8

class Record < ActiveRecord::Base
  serialize :fields

  belongs_to :issue
  belongs_to :subject

  delegate :main_subject, :to => :subject

  def self.subjects_dictionary
    @subjects_dictionary ||= YAML.load_file(Rails.root.join('config', 'abstracts', 'subjects.yml'))
  end

  def self.document_codes
    @document_codes ||= YAML.load_file(Rails.root.join('config', 'abstracts', 'document_codes.yml'))
  end

  searchable do
    text :year, :month, :title, :authors, :keywords, :summary, :tipe
    string :year
    string :month
  end

  def self.search(params)
    solr_search do
      fulltext params[:search]

      all_of do
        with(:year, params[:year]) if params[:year]
#        with(:main_subject, params[:main_subject]) if params[:main_subject]
      end


      facet(:month)
      facet :year, :zeros => true, :sort => :index

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

  def summary
    fields['100']
  end

  def main_subject_code
    fields['501'][0..1]
  end

  def subject_code
    fields['501']
  end

  def year
    fields['514'][2..5]
  end

  def month
    fields['507']
  end

  def tipe
    self.class.document_codes[fields["035"]]
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

