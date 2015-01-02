Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root    'sessions#new'
  
  controller :sessions do
    get     'login'   => :new
    post    'login'   => :create
    delete  'logout'  => :destroy
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  controller :tickets do
    get 'tickets/all'               => :index,           status: 'all'
    get 'tickets/my'                => :my,              status: 'my'
    get 'tickets/assigned_to_me'    => :assigned_to_me,  status: 'assigned_to_me'
    get 'tickets/open'              => :index,           status: 'open'
    get 'tickets/unassigned'        => :index,           status: 'unassigned'
    get 'tickets/work_in_progress'  => :index,           status: 'work_in_progress'
    get 'tickets/hold'              => :index,           status: 'on_hold'
    get 'tickets/on_hold'           => :index,           status: 'on_hold'
    get 'tickets/closed'            => :index,           status: 'closed'
  end
  
  controller :employees do
    get 'employees/all'             => :index
    get 'employees/active'          => :index,         status: 'active'
    get 'employees/inactive'        => :index,         status: 'inactive'
    get 'employees/admin'           => :index,         status: 'admin'
  end

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
  controller :tickets do
    patch 'tickets/:id/assign_to_me'  => :assign_to_me,  as: :assign_to_me
    get   'tickets/:id/close_ticket'  => :close_ticket,  as: :close_ticket
    get   'tickets/:id/reopen_ticket' => :reopen_ticket, as: :reopen_ticket
  end

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :sessions, only: [:new, :create, :destroy]
  resources :topics
  resources :offices
  resources :employees do
    resources :tickets
  end
  resources :technician do
    resources :tickets
  end
  resources :cities
  resources :states
  resources :tickets do
    resources :comments
  end

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
