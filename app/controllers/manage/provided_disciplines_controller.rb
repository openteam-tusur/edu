# encoding: utf-8

class Manage::ProvidedDisciplinesController < Manage::ApplicationController
  load_and_authorize_resource :class => 'Chair'
  actions :only => []

  belongs_to :chair, :finder => :find_by_slug

  def index
    @curriculum = Curriculum.find_by_slug(params[:curriculum_id])
    @educations_by_semesters = @chair.provided_educations_for_curriculum_grouped_by_semesters(@curriculum)
  end
end
