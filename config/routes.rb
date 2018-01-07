Rails.application.routes.draw do
  get 'feed/feed'

  get 'comments/index'

  get 'comments/new'

  get 'comments/create'

  get 'comments/show'

  get "/" => "feed#show"

  get "/comments" => "comments#show"

  get "/terminal" => "home#show"

  get "/:page" => "home#show"

  resources :comments
end
