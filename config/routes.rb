Portal::Application.routes.draw do
  namespace :manage do
    resources :chairs, :only => [:index, :show], :shallow => true do
      resources :specialities do
        resources :disciplines, :except => [:index, :show]
      end
    end
    root :to => "chairs#index"
  end

  root :to => "manage/chairs#index"
end

