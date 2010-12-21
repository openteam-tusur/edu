Portal::Application.routes.draw do
  devise_for :users

  namespace :manage do
    resources :chairs, :only => [:index, :show] do
      resources :specialities do
        resources :plan_curriculums, :path => :curriculums do
          put :transit, :on => :member
          resources :plan_semesters, :path => :semesters do
            resources :plan_educations, :path => :educations
          end
        end
      end
    end
    root :to => "chairs#index"
  end

  root :to => "manage/chairs#index"
end

