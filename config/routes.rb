Rails.application.routes.draw do

  resources :pages



  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }




  resources :articles
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'articles#index'



  resources :articles do
    resources :pages
  end



  get  'pannel_control/index'
  post 'pannel_control/delete' => 'pannel_control#delete'

  get 'pages/default_photo/:id' => 'pages#default_photo'
  post 'pages/default_photo/:id' => 'pages#set_photo'

  get 'pages/rename_photo/:id_page' => 'pages#rename_photo'
  post 'pages/rename_photo/:id_page' => 'pages#set_name_photo'

  get 'filtered' => 'articles#filtered'
  post 'filtered' => 'articles#filtered'

  post 'articles/:article_id' => 'articles#destroy'
  post 'articles/:id/edit' => 'articles#edit'

  post '/articles/:article_id/pages/new' => 'pages#new'







  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
