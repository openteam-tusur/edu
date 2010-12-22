Portal::Application.routes.draw do
  devise_for :users,  :controllers => { :registrations => "users/registrations",
                                        :sessions => 'users/sessions' }

  resources :users do |user|
    resource :human, :only => [:edit, :update]
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
  match ":id" => "chairs#show", :as => :chair
end

