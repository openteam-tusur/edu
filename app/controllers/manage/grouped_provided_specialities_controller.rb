# encoding: utf-8

class Manage::GroupedProvidedSpecialitiesController < Manage::ApplicationController
  skip_authorization_check
  belongs_to :chair, :finder => :find_by_slug
  actions :index

  protected
    def collection
      parent.grouped_provided_specialities
    end
end
