Portal::Application.routes.draw do
  mount Api => '/'

  devise_for :users

  resources :humans, :only => [:index, :show]

  resources :records

  resource :human, :except => [:index, :delete, :destroy], :path => '/profile' do
    resources :graduates, :only => [:new, :create]
    resources :students,  :only => [:new, :create]
    resources :employees, :only => [:new, :create]
    resources :postgraduates, :only => [:new, :create]
  end

  match '/profile'  => 'humans#show', :as => :profile, :method => :get
  match '/training' => 'training#index'
  match '/science' => 'science#index'


  scope '/training' do
    resources :publications, :only => [:index, :show]
  end

  resources :chairs, :only => [:index, :show]

  get '/api_for_workprogram/publications' => 'api/publications#index'

  namespace :manage do
    match '/publications/get_fields' => 'publications#get_fields', :method => :post
    match '/educations/get_fields'   => 'educations#get_fields',   :method => :post

    match '/humans/:id/merge_with/:namesake_id' => 'humans#merge_with', :as => 'human_merge_with'

    resources :specialities, :except => :show

    resources :licenses, :only => :index do
      get :roster, :on => :collection
    end


    resources :disks, :except => [:show] do
      resources :issues do
        resources :records
      end
    end


    resources :humans, :shallow => true do
      get :check, :on => :collection

      resource :user, :only => [:edit, :update] do
        get :flush_password, :on => :member
      end

      resources :roles do
        put :transit, :on => :member
      end
    end

    resources :chairs, :only => [:index, :show] do
      resources :grouped_provided_specialities
      resources :grouped_specialities
      resources :employees, :except => :show

      resources :publications do
        get :to_report, :on => :member
        put :transit, :on => :member
        resources :publication_disciplines, :except => [:index, :show]
      end

      resources :curriculums do
        resources :provision_educations_grouped_by_semesters
        resources :provided_educations_grouped_by_semesters
        put :transit, :on => :member

        resources :studies, :except => [:index, :show]

        resources :semesters do
          resources :educations
        end
      end
    end


    root :to => 'chairs#index'
  end

  root :to => 'application#main_page'

  match 'help' => 'application#help_page'

  resources :autocompletes, :only => [] do
    get :disciplines,           :on => :collection
    get :discipline_educations, :on => :collection
    get :specialities,          :on => :collection
    get :authors,               :on => :collection
    get :publications,          :on => :collection
  end

  match '/attachments/:id/download/' => 'attachments#download', :as => :attachment
end

