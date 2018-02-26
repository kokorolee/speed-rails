Rails.application.routes.draw do

  # get 'notifications' => 'notifications#index'

  resources :notifications
  devise_for :partners, controllers: {registrations: "partners/registrations", sessions: "partners/sessions", passwords: "partners/passwords"}
  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions", passwords: "users/passwords"}

  scope '/', module: :frontend, as: :frontend do
    root 'todos#index'

    # get 'todo_todolist'     =>'home#todolist'
    # get 'todo_backlog'      =>'home#backlog'
    # get 'todo_duesoon'      =>'home#duesoon'
    # get 'archived_todo'      =>'teams#team_archived_todo'
    # get 'team_todo_list'      =>'home#team_todo_list'
    resources :datums
    resources :users
    resources :todos do
      member do
        get 'check_done'
      end
    end
    resources :todo_lists do
      resources :todos
    end
    resources :check_lists do
      resources :todos
    end

    resources :comments do
      collection do
        get 'view_comments'
      end
    end
    # resources :workloads do
    #   collection do
    #     get 'view_team'
    #     get 'view_member'
    #   end
    # end

    resources :teams do
      resources :check_lists
      resources :todo_lists
      resources :workflows
      resources :activities
      member do
        get 'team_archived_todo'
      end
      resources :workloads do
        collection do
          get 'view_member'
          get 'view_team'
        end
      end
    end

    get 'members'  =>'members#index'
    resources :workflows

    get 'workloads'  =>'workloads#index'
    # get 'check_lists'  =>'check_lists#index'
    get 'completes'  =>'completes#index'
    get 'duesoons'  =>'duesoons#index'
    get 'backlogs'  =>'backlogs#index'
  end

  scope :admin, module: :admin, as: :admin do
    root 'users#index'
    resources :users
    resources :partners
    resources :customers
    resources :products
    resources :categories
    resources :permissions
    resources :orders
    resources :notes
    resources :roles
    resources :partner_types
    scope '/settings' do
      root 'properties#index'
      resources :group_properties
      resources :properties
    end

  end
  # get      '*path'       => redirect('404')
  # mount ActionCable.server => '/cable'
  mount FoxyCrmAPI => '/api/v1'

end
