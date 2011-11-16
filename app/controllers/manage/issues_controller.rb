class Manage::IssuesController < Manage::ApplicationController
  load_and_authorize_resource
  belongs_to :disk
  actions :index, :create, :destroy

  def create
    create! do |success, failure|
      failure.html {
        @issues = @disk.issues.all
        render :action => :index and return
      }
    end
  end
end

