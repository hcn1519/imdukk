Rails.application.routes.draw do
  root 'visitor#main'
  
  get 'register/info1'
  get 'register/info2'
  post 'register/infoget'

  get 'mission/detail/:id', to: 'mission#detail'
  post 'mission/mission_create'                                                           #작성자가 미션 작성하는 페이지
  post 'mission/performed_mission_create'                                                 #수행자가 미션 작성하는 페이지
  post 'mission/performed_mission_create/:id' => 'mission#performed_mission_create'
                                                                                          # 삭제
  get '/mission/:id/destroy' => 'home#mission_destory'                                    # 작성자가 본인 글 삭제
  get '/mission/performed_mission:id/destroy' => 'home#mission_destory'                   # 수행자가 본인 글 삭제
  
                                                                                          # 수정
  post '/mission/:id/edit' => 'home#mission_edit'                                         # 작성자 본인 글의 수정이 실제로 일어나는 페이지
  get '/mission/:id/edit/view' => 'home#mission_edit_view'                                # 작성자 본인이 수정한 게 보여지는 페이지
  
  post 'mission/mission_comment_create'
  
  # post '/mission/performed_mission:id/edit' => 'home#performed_mission_edit'              # 수행자 본인 글의 수정이 실제로 일어나는 페이지
  # get '/mission/performed_mission:id/edit/view' => 'home#performed_mission_edit_view'     # 수행자 본인이 수정한 게 보여지는 페이지
  
  
  
  get 'visitor/main'

  get 'home/main'
  get 'home/timeline/:id', to: 'home#timeline'
  get 'home/timeline_temp'
  get 'home/mission_detail'
  
  devise_for :users, :controllers => { omniauth_callbacks: 'user/omniauth_callbacks', registrations: "user/registrations" }
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
