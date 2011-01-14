# encoding: utf-8

class AutocompletesController < ActionController::Base

  def disciplines
    disciplines = Plan::Discipline.solr_search do
      text_fields do
        terms.each do | term |
          with(:name).starting_with term
        end
      end
    end.results
    disciplines.map! do | discipline |
      { :id => discipline.id, :value => discipline.name }
    end
    render :text => disciplines.to_json
  end

private

  def terms
    params[:term].split(/[^[:alnum:]]+/)
  end

end
