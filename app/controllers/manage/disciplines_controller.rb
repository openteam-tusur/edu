# encoding: utf-8
class Manage::DisciplinesController < Manage::ApplicationController

  authorize_resource :class => Plan::Discipline

  def search
    disciplines = Plan::Discipline.search do
      with("name").starting_with(params[:term].mb_chars.downcase)
    end.results
    ActiveRecord::Base.include_root_in_json = false
    render :text => disciplines.to_json(:methods => [:name])
  end

end
