Rails.application.routes.draw do
  get 'comments/index'

  get 'comments/new'

  get 'comments/create'

  get 'comments/show'

  get "/comments" => "comments#show"

  get "/" => "home#show"

  get "/:page" => "home#show"

  resources :comments
end
