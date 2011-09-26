# encoding: utf-8

class DisksController < CrudController

load_and_authorize_resource

def index
  @disks = Disk.all.each_with_object({}) { | disk, grouped | grouped[disk.year] ||= []; grouped[disk.year] << disk }
end

end

