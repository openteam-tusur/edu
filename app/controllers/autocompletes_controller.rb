# encoding: utf-8

class AutocompletesController < ActionController::Base

  def disciplines
    disciplines = Plan::Discipline.all
    disciplines.map! do | discipline |
      { :id => discipline.id, :value => discipline.name }
    end
    render :text => disciplines.to_json
  end

end
