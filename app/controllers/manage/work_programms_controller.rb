class Manage::WorkProgrammsController < Manage::ApplicationController

  load_and_authorize_resource :class=> WorkProgramm

  custom_actions :resource => [:transit, :delete]

  defaults :resource_class => WorkProgramm,
           :instance_name => 'work_programm'

  belongs_to :chair, :finder => :find_by_slug

  def index
    @work_programms = WorkProgramm.solr_search do
      keywords params[:query]
    end.results
  end

  def transit
    transit! do
      @work_programm.send "#{params[:event]}!" if @work_programm.aasm_events_for_current_state.include?(params[:event].to_sym)
      redirect_to resource_path and return
    end
  end

end

