Rails.application.routes.draw do
  root 'visitor#main'
  
  get 'register/info1'
  get 'register/info2'
  post 'register/infoget'

  get 'mission/detail/:id', to: 'mission#detail'
  # get 'mission/detail/performed_mission/:id', to: 'mission#detail'

  post 'mission/mission_create'                                                           #작성자가 미션 작성하는 페이지
  post 'mission/performed_mission_create'                                                 #수행자가 미션 작성하는 페이지
  post 'mission/performed_mission_create/:id' => 'mission#performed_mission_create'
                                         
                                                                                          # 삭제
  get 'mission/destroy/:id' => 'mission#missione_destroy'                                  # 작성자가 본인 미션글 삭제
  get 'mission/performed_mission/destroy/:id' => 'mission#performed_mission_destroy'      # 수행자가 본인 수행글 삭제
  
  get 'mission/mission_editview/:id' => 'mission#mission_editview'                            #작성자 본인 글 수정 내용 입력하는 페이지                                                                                
  post 'mission/mission_edit/:id' => 'mission#mission_edit'                                    #입력한 내용이 임시로 날아갔다가 돌아옴

  
  # post 'home/update_write/:id' => 'home#update_write'
  # get 'home/update/:id' => 'home#update'
  
  post 'mission/mission_comment_create'
  
 
  
  
  
  
  # post '/mission/performed_mission:id/edit' => 'home#performed_mission_edit'              # 수행자 본인 글의 수정이 실제로 일어나는 페이지
  # get '/mission/performed_mission:id/edit/view' => 'home#performed_mission_edit_view'     # 수행자 본인이 수정한 게 보여지는 페이지
  
  
  
  get 'visitor/main'

  get 'home/main'
  get 'home/timeline/:id', to: 'home#timeline'
  get 'home/timeline_temp'
  get 'home/missionLike/:id', to: 'home#missionLike'
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
