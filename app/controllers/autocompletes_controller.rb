# encoding: utf-8

class AutocompletesController < ActionController::Base

  def authors
    authors = Human.available_authors(params[:term])
    authors.map! do |author|
      { :id => author.id, :value => author.full_name_with_posts }
    end
    render :text => authors.to_json
  end

  def disciplines
    disciplines = Plan::Discipline.solr_search do
      text_fields do
        terms.each do | term |
          with(:name).starting_with term.mb_chars.downcase
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
