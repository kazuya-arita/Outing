Rails.application.routes.draw do

#管理者用
# URL /admin/sign_in ...
  devise_for :admin, skip: [:passwords, :registrations], controllers: {
    sessions: "admin/sessions"
  }

#admin/homesコントローラー
get "admin" => "admin/homes#top"
namespace :admin do
  resources :homes, only: [:show] #投稿詳細画面の閲覧
end

#admin/usersコントローラー
namespace :admin do
  resources :users, only: [:show, :edit, :update]
end

#admin/searchsコントローラー
get "admin/search" => "admin/searchs#search"

#ユーザー用
# URL /users/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  #public/post_itemsコントローラー
  scope module: :public do
    resources :post_items, only: [:index, :new, :create, :show, :destroy ] do
      resources :post_comments, only: [:create]
      resource :favorites, only: [:create, :destroy]
      resource :repost_items, only: [:create, :destroy]
    end
  end

  #public/usersコントローラー
  get "users/confirm" => "public/users#confirm"
  scope module: :public do
    resources :users, only: [:show, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
      member do
        get :favorites
      end
    end
  end

  #public/searchsコントローラー
  get "search" => "public/searchs#search"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
