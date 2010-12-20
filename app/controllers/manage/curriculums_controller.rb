class Manage::CurriculumsController < Manage::ApplicationController

  defaults :resource_class => Plan::Curriculum,
           :instance_name => :plan_curriculum

  custom_actions :resource => :transit

  belongs_to :chair, :finder => :find_by_slug, :shallow => true do
    belongs_to :speciality
  end

  def transit
    transit! do
      @plan_curriculum.send "#{params[:event]}!" if @plan_curriculum.aasm_events_for_current_state.include?(params[:event].to_sym)
      redirect_to manage_curriculum_path(@plan_curriculum) and return
    end
  end
end
