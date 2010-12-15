Portal::Application.routes.draw do
  namespace :manage do
    resources :chairs, :only => [:index, :show]
  end

  root :to => "manage/chairs#index"
end
