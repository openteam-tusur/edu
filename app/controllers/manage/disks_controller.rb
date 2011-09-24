# encoding: utf-8

class Manage::DisksController < Manage::ApplicationController
  load_and_authorize_resource

  def index
    @disks = Disk.all.each_with_object({}) { | disk, grouped | grouped[disk.year] ||= []; grouped[disk.year] << disk }
  end

  def create
    create! { new_manage_disk_issue_path(@disk) }
  end

  def update
    update! { manage_disk_issues_path(@disk) }
  end
end

