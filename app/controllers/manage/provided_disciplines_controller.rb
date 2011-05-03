# encoding: utf-8
class Manage::ProvidedDisciplinesController < Manage::ApplicationController
  load_and_authorize_resource :class => 'Chair'
  actions :only => []

  belongs_to :chair, :finder => :find_by_slug

  def index
    @curriculum = Curriculum.find_by_slug(params[:curriculum_id])
    @studies = @chair.provided_studies_for_curriculum(@curriculum)
  end
end
