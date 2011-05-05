# encoding: utf-8

class Manage::GroupedSpecialitiesController < Manage::ApplicationController
  skip_authorization_check
  belongs_to :chair, :finder => :find_by_slug
  actions :index

  protected
    def collection
      parent.grouped_specialities
    end
end
