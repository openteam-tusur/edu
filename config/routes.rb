Portal::Application.routes.draw do
  devise_for :users,  :controllers => { :registrations => "users/registrations",
                                        :sessions => 'users/sessions',
                                        :passwords => 'users/passwords' }

  resource :human, :only => [:show, :edit, :update] do
    namespace :roles do
      resources :students
      resources :employees
    end
  end

  namespace :manage do
    resources :humans, :shallow => true do
      get :check, :on => :collection
      resources :roles do
        put :transit, :on => :member
      end
    end
    resources :chairs, :only => [:index, :show] do
      resources :employees, :except => [:show]
      resources :work_programms do
        put :transit, :on => :member
        resources :resource_disciplines, :except => [:index, :show]
      end

      resources :work_books do
        put :transit, :on => :member
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

    root :to => "chairs#index"
  end

  root :to => "chairs#index"

  resources :autocompletes, :only => [] do
    get :disciplines, :on => :collection
    get :authors, :on => :collection
  end

  match "/:id" => "chairs#show", :as => :chair
  match "/attachments/:id/download/" => "attachments#download"
end

