# encoding: utf-8

class Manage::CurriculumsController < Manage::ApplicationController

  load_and_authorize_resource :class => 'Curriculum'

  custom_actions :resource => [:transit, :delete]

  defaults :finder => :find_by_slug

  actions :all

  belongs_to :chair, :finder => :find_by_slug

  def index
    @specialities = @chair.grouped_specialities
  end

  def show
    show! do
      @semester = @curriculum.semesters.first
    end
  end

  def transit
    transit! do
      @curriculum.send "#{params[:event]}!" if @curriculum.aasm_events_for_current_state.include?(params[:event].to_sym)
      redirect_to resource_path and return
    end
  end
end

