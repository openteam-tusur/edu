# encoding: utf-8

class Manage::RecordsController < Manage::ApplicationController
  load_and_authorize_resource
  belongs_to :issue

end

