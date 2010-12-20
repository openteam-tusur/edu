Portal::Application.routes.draw do
  devise_for :users

  namespace :manage do
    resources :chairs, :only => [:index, :show], :shallow => true do
      resources :specialities do
        get :transit, :on => :member
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

