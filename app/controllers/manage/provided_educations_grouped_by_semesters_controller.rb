# encoding: utf-8

class Manage::ProvidedEducationsGroupedBySemestersController < Manage::ApplicationController
  skip_authorization_check
  actions :index
  belongs_to :chair, :finder => :find_by_slug
  belongs_to :curriculum, :finder => :find_by_slug

  protected
    def collection
      parent.provided_educations_grouped_by_semesters
    end
end
