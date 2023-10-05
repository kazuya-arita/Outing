Rails.application.routes.draw do
#管理者用 
# URL /admin/sign_in ...
  devise_for :admin, skip: [:passwords, :registrations], controllers: {
    sessions: "admin/sessions"
  }
  
#ユーザー用
# URL /users/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  #public/postsコントローラー
  get "search" => "public/posts#search"
  scope module: :public do
   resources :posts, only: [:index, :new, :create, :show, :destroy ]
  end   
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
