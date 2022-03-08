Rails.application.routes.draw do

  root to:"homes#top" #2022/2/15(debug)
  devise_for :users #2022/2/15(debug)

  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only:[:create, :destroy]
    resources :book_comments, only:[:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only:[:create, :destroy]
    get "relationships/followings" => "relationships#followings", as: "followings"
    get "relationships/followers" => "relationships#followers", as: "followers"
  end

  get "searches/search" => "searches#search", as: "search"
  get "searches/result" => "searches#result", as: "result"

  resources :chats, only: [:show, :create]

  resources :groups, only: [:new, :index, :show, :edit, :create, :update, :destroy] do
    get "join" => "groups#join"
  end

  # devise_for :users #2022/2/15(debug)

end #2022/2/15(debug)
