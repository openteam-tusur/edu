Portal::Application.routes.draw do
  devise_for :users,  :controllers => { :registrations => "users/registrations",
                                        :sessions => 'users/sessions' }

  resource :human, :only => [:show, :edit, :update] do
    namespace :roles do
      resources :students
      resources :teachers
    end
  end


  namespace :manage do
    resources :chairs, :only => [:index, :show] do
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

