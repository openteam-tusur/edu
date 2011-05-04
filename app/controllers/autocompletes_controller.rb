# encoding: utf-8

class AutocompletesController < ApplicationController

  def authors
    authors = Human.autocomplete_authors(params[:term])

    authors.map! do |author|
      { :id => author.id, :value => author.full_name_with_posts }
    end
    render :text => authors.to_json
  end

  def specialities
    specialities = Speciality.solr_search do
      text_fields do
        terms.each do | term |
          with(:info).starting_with term.mb_chars.downcase
        end
      end
    end.results
    specialities.map! do |speciality|
      { :id => speciality.id, :value => speciality.autocomplete_value }
    end
    render :text => specialities.to_json
  end

  def publications
    publications = Publication.solr_search do
      keywords params[:term]
    end.results

    publications.map! do | publication |
      { :id => publication.id, :value => publication.to_s }
    end

    render :text => publications.to_json
  end

  def disciplines
    disciplines = Discipline.solr_search do
      text_fields do
        terms.each do | term |
          with(:name).starting_with term.mb_chars.downcase
        end
      end
      with(:speciality_id, params[:speciality_id])
    end.results
    disciplines.map! do | discipline |
      { :id => discipline.id, :value => discipline.name }
    end

    render :text => disciplines.to_json
  end

  def discipline_educations
    discipline = Discipline.find(params[:discipline_id])
    @publication_discipline = PublicationDiscipline.new(:discipline_id => discipline.id)
    @grouped_educations = discipline.educations_grouped_by_curriculums
    render :text => "Обучения для этой дисциплины не запланировано" and return if @grouped_educations.empty?
    render :partial => "crud/manage/publication_disciplines/discipline_educations", :layout => false
  end

private

  def terms
    params[:term].split(/[^[:alnum:]]+/)
  end

end

