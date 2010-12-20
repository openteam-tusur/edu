Portal::Application.routes.draw do
  namespace :manage do
    resources :chairs, :only => [:index, :show], :shallow => true do
      resources :specialities do
        member do
          get :publish
          get :unpublish
        end
        resources :disciplines, :except => [:index, :show]
        resources :semesters do
          resources :educations
        end
      end
    end
    root :to => "chairs#index"
  end

  root :to => "manage/chairs#index"
end

