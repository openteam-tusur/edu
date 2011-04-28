# encoding: utf-8

class Manage::PublicationDisciplinesController < Manage::ApplicationController

  load_and_authorize_resource


  belongs_to :chair, :finder => :find_by_slug do
    belongs_to :publication
  end

  actions :all, :except => [:index, :show]

  before_filter :prepare_grouped_educations_from_params, :only => :create
  before_filter :prepare_grouped_educations_from_publication_discipline, :only => [:edit, :update]

  def update
    params[:publication_discipline][:education_ids] ||= []
    update!
  end

  private

  def prepare_grouped_educations_from_params
    discipline = Discipline.find(params[:publication_discipline][:discipline_id])
    @grouped_educations = discipline.educations_grouped_by_curriculums
  end

  def prepare_grouped_educations_from_publication_discipline
    @grouped_educations = @publication_discipline.discipline.educations_grouped_by_curriculums
  end

end

