Rails.application.routes.draw do

  root  'sessions#new'

  controller :sessions do
    get     'login'   => :new
    post    'login'   => :create
    delete  'logout'  => :destroy
  end

  resources :tickets do
    collection do
      get 'all'              => :index,          status: 'all'
      get 'my'               => :my,             status: 'my'
      get 'assigned_to_me'   => :assigned_to_me, status: 'assigned_to_me'
      get 'open'             => :index,          status: 'open'
      get 'unassigned'       => :index,          status: 'unassigned'
      get 'work_in_progress' => :index,          status: 'work_in_progress'
      get 'hold'             => :index,          status: 'on_hold'
      get 'on_hold'          => :index,          status: 'on_hold'
      get 'closed'           => :index,          status: 'closed'
    end

    member do
      patch 'assign_to_me'
      patch 'close'
      patch 'reopen'
    end

    resources :comments, only: [:create]
  end

  resources :employees, except: [:show, :destroy] do
    collection do
      get 'all'        => :index
      get 'active'     => :index, status: 'active'
      get 'inactive'   => :index, status: 'inactive'
      get 'technician' => :index, status: 'technician'
    end

    member do
      patch 'hide'
      get   'assigned_tickets'
    end

    resources :tickets, only: [:index]
  end

  resources :cities, except: [:show, :destroy] do
    member do
      patch 'hide'
    end
  end

  resources :offices, except: [:show, :destroy] do
    member do
      patch 'hide'
    end
  end

  resources :topics, except: [:show, :destroy] do
    member do
      patch 'hide'
    end
  end

end
