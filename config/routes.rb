Recipes::Application.routes.draw do
  resources :recipes

  match 'most_recent' => 'recipes#most_recent', via: :get

  root to: 'recipes#index'
end
