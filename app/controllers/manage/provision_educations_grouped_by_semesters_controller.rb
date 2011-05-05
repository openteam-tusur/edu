# encoding: utf-8

class Manage::ProvisionEducationsGroupedBySemestersController < Manage::ApplicationController
  skip_authorization_check
  actions :index
  belongs_to :chair, :finder => :find_by_slug
  belongs_to :curriculum, :finder => :find_by_slug

  protected
    def collection
      parent.provision_educations_grouped_by_semesters
    end
end
