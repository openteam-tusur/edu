class Manage::CurriculumsController < Manage::ApplicationController

  load_and_authorize_resource :class => Plan::Curriculum

  custom_actions :resource => [:transit, :delete]

  defaults :resource_class => Plan::Curriculum,
           :instance_name => :curriculum,
           :finder => :find_by_slug

  actions :all, :except => [:index]

  belongs_to :chair, :finder => :find_by_slug do
    belongs_to :speciality, :finder => :find_by_slug
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

