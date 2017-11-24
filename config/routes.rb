Rails.application.routes.draw do
    get "/" => "home#show"
    get "/:page" => "home#show"
end
