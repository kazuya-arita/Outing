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
  
  #public/post_itemsコントローラー
  get "search" => "public/posts#search"
  scope module: :public do
    resources :post_items, only: [:index, :new, :create, :show, :destroy ] do
      resources :post_comments, only: [:create]
      resource :favorites, only: [:create, :destroy]
    end 
  end   
  
  #public/usersコントローラー
  get "users/confirm" => "public/users#confirm"
  scope module: :public do
    resources :users, only: [:show, :edit, :update, :destroy]
  end  
  
  #public
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
