# encoding: utf-8

class IssuesController < CrudController
  load_and_authorize_resource
  belongs_to :disk
  actions :index, :show
end

