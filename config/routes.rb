Portal::Application.routes.draw do
  devise_for :users,  :controllers => { :registrations => "users/registrations",
                                        :sessions => 'users/sessions',
                                        :passwords => 'users/passwords' }

  resource :human, :only => [:show, :edit, :update] do
    namespace :roles do
      resources :students
      resources :teachers
    end
  end

  namespace :manage do
    resources :disciplines, :only => [] do
      get :search, :on => :collection
    end
    resources :humans, :shallow => true do
      resources :roles do
        put :transit, :on => :member
      end
    end
    resources :chairs, :only => [:index, :show] do
      resources :teachers, :except => [:show]
      resources :work_programms do
        put :transit, :on => :member
        resources :authors, :except => [:index, :show]
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
  match "/:id" => "chairs#show", :as => :chair
  match "/attachments/:id/download/" => "attachments#download"
end

