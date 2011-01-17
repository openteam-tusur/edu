# encoding: utf-8

class AutocompletesController < ActionController::Base

  def authors
    authors = Human.available_authors(params[:term])
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
      { :id => speciality.id, :value => "#{speciality.code} (#{speciality.chair.abbr}) - #{speciality.name}" }
    end
    render :text => specialities.to_json
  end

  def disciplines
    disciplines = Plan::Discipline.solr_search do
      text_fields do
        terms.each do | term |
          with(:name).starting_with term.mb_chars.downcase
        end
      end
      with(:speciality_id, params[:speciality_id]) if params[:speciality_id]
    end.results
    disciplines.map! do | discipline |
      { :id => discipline.id, :value => discipline.name }
    end
    render :text => disciplines.to_json
  end

  def discipline_educations
    discipline = Plan::Discipline.find(params[:discipline_id])
    @grouped_educations = discipline.educations_grouped_by_curriculums
    render :text => "Обучения для этой дисциплины не запланировано" and return if @grouped_educations.empty?
    render :layout => false
  end

private

  def terms
    params[:term].split(/[^[:alnum:]]+/)
  end

end
