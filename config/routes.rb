Portal::Application.routes.draw do
  namespace :manage do
    resources :chairs, :only => [:index, :show], :shallow => true do
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

  root :to => "manage/chairs#index"
end

