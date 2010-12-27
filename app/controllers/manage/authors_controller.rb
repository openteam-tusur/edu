class Manage::AuthorsController < Manage::ApplicationController
  load_and_authorize_resource :class=> Author

  actions :all, :except => [:index, :show]

  belongs_to :chair, :finder => :find_by_slug do
    polymorphic_belongs_to :work_programm
  end
end
