Portal::Application.routes.draw do
  namespace :manage do
    resources :chairs, :only => [:index, :show] do
      resources :specialities
    end
  end

  root :to => "manage/chairs#index"
end

