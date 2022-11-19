Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
 }
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

namespace :admin do
  root to: "homes#top"
  resources :items, except: [:destroy]
  resources :genres, only: [:index,:create,:edit,:update]
  resources :customers, only: [:index,:show,:edit,:update]
  resources :orders, only: [:show,:update]
  resources :order_items, only: [:update]
end

scope module: :public do
  root to: "homes#top"
  get "about" => "homes#about"
  resources :items, only: [:index,:show]
  get "customers/mypage" => "customers#show", as: "mypage"
  get "customers/info/edit" => "customers#edit", as: "info_edit"
  patch "customers/info" => "customers#update", as: "info"
  get "customers/unsubscribe" => "customers#unsubscribe", as: "unsubscribe"
  patch "/customers/withdraw" => "customers#withdraw", as: "withdraw"
  resources :cart_items, only: [:index,:update,:destroy,:create]
  delete "cart_items/destroy_all" => "cart_items#destroy_all" , as: "destroy_all"
  resources :orders, only: [:new,:create,:index,:show]
  post "orders/confirm" => "orders#confirm", as: "confirm"
  post "orders/complete" => "orders#complete", as: "complete"
  resources :deliveries, except: [:show]
  end

end