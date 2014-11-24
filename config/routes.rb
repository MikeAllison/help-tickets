Rails.application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root    'sessions#new'
  get     'login'   => 'sessions#new'
  post    'login'   => 'sessions#create'
  delete  'logout'  => 'sessions#destroy'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  get 'tickets/all' => 'tickets#index'
  get 'tickets/my' => 'tickets#my', status: 'my'
  get 'tickets/open' => 'tickets#index', status: 'open'
  get 'tickets/unassigned' => 'tickets#index', status: 'unassigned'
  get 'tickets/work_in_progress' => 'tickets#index', status: 'work_in_progress'
  get 'tickets/hold' => 'tickets#index', status: 'on_hold'
  get 'tickets/on_hold' => 'tickets#index', status: 'on_hold'
  get 'tickets/closed' => 'tickets#index', status: 'closed'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
  get 'tickets/:id/close_ticket' => 'tickets#close_ticket', as: :close_ticket
  get 'tickets/:id/reopen_ticket' => 'tickets#reopen_ticket', as: :reopen_ticket

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :sessions, only: [:new, :create, :destroy]
  resources :topics
  resources :offices
  resources :employees
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
