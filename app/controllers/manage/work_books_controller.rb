class Manage::WorkBooksController < Manage::ApplicationController

  load_and_authorize_resource :class => WorkBook

  custom_actions :resource => [:transit, :delete]

  defaults :resource_class => WorkBook,
           :instance_name => 'work_book'

  belongs_to :chair, :finder => :find_by_slug

  def transit
    transit! do
      @work_book.send "#{params[:event]}!" if @work_book.aasm_events_for_current_state.include?(params[:event].to_sym)
      redirect_to resource_path and return
    end
  end
end

