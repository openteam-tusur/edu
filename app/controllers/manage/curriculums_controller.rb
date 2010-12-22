class Manage::CurriculumsController < Manage::ApplicationController

  load_and_authorize_resource :class => Plan::Curriculum

  custom_actions :resource => [:transit, :delete]

  defaults :resource_class => Plan::Curriculum,
           :instance_name => :curriculum,
           :finder => :find_by_study

  belongs_to :chair, :finder => :find_by_slug do
    belongs_to :speciality, :finder => :find_by_slug
  end


  def index
    index! do
      redirect_to parent_path and return
    end
  end

  def transit
    transit! do
      @curriculum.send "#{params[:event]}!" if @curriculum.aasm_events_for_current_state.include?(params[:event].to_sym)
      redirect_to resource_path and return
    end
  end
end

