Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to:"homes#top" #2022/2/15(debug)
  devise_for :users #2022/2/15(debug)

  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]
  resources :users, only: [:index,:show,:edit,:update]
  # devise_for :users #2022/2/15(debug)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end #2022/2/15(debug)
