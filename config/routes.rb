Portal::Application.routes.draw do
  devise_for :users,  :controllers => { :registrations => "users/registrations",
                                        :sessions => 'users/sessions',
                                        :passwords => 'users/passwords' }

  resource :human, :only => [:show, :edit, :update] do
    namespace :roles do
      resources :students, :only => [:new, :create, :edit, :update]
      resources :employees, :only => [:new, :create, :edit, :update]
    end
  end

  resources :chairs, :only => [:index, :show] do
  resources :employees, :except => [:show]
      resources :publications do
        put :transit, :on => :member
        resources :publication_disciplines, :except => [:index, :show]
      end

      resources :specialities do
        resources :curriculums do
          put :transit, :on => :member
          resources :semesters do
            resources :educations
        end
          end
          end
    resources :provided_specialities, :only => :index
    end


  namespace :manage do
    match "/publications/get_fields" => "publications#get_fields", :method => :post
    resources :humans, :shallow => true do
      get :check, :on => :collection
      resource :user, :only => [:edit, :update] do
        get :flush_password, :on => :member
      end
      resources :roles do
        put :transit, :on => :member
      end
    end

    resources :chairs, :only => [:index, :show] do
      resources :employees, :except => [:show]
      resources :publications do
        put :transit, :on => :member
        resources :publication_disciplines, :except => [:index, :show]
      end

      resources :specialities do
        resources :curriculums do
          put :transit, :on => :member
          resources :semesters do
            resources :educations
          end
        end
      end
    end

    match "chairs/:chair_id/provided_specialities" => "provided_specialities#index",
          :as => :chair_provided_specialities
    match "chairs/:chair_id/:curriculum_id/provided_disciplines" => "provided_disciplines#index",
          :as => :chair_provided_disciplines

    root :to => "chairs#index"
  end

  root :to => "chairs#index"

  resources :autocompletes, :only => [] do
    get :disciplines, :on => :collection
    get :discipline_educations, :on => :collection
    get :specialities, :on => :collection
    get :authors, :on => :collection
  end

  match "/:id" => "chairs#show", :as => :chair
  match "/attachments/:id/download/" => "attachments#download"
end

