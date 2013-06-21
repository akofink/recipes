Recipes::Application.routes.draw do
  get "users/create"
  get "users/show"
  get "users/update"
  get "users/destroy"
  get "users/index"
  get "users/new"
  get "users/edit"
  resources :recipes

  match 'most_recent' => 'recipes#most_recent', via: :get

  root to: 'recipes#index'
end
