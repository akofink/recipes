Recipes::Application.routes.draw do
  resources :users do
    member do
      get 'delete'
    end
  end
  match 'signup' => 'users#new', via: :get

  resources :sessions
  match 'login' => 'sessions#new', via: :get
  match 'logout' => 'sessions#destroy', via: :get


  resource :pages
  match 'about' => 'pages#about', via: :get

  resources :recipes
  match 'most_recent' => 'recipes#most_recent', via: :get

  root to: 'recipes#index'
end
