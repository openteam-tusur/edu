# encoding: utf-8

class Manage::DisksController < Manage::ApplicationController
  load_and_authorize_resource

  def index
    @disks = Disk.all.each_with_object({}) { | disk, grouped | grouped[disk.year] ||= []; grouped[disk.year] << disk }
  end

  private
    def smart_resource_url
      manage_disk_issues_url(@disk)
    end

end

