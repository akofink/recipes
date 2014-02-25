Recipes::Application.routes.draw do
  resources :comments
  resources :images
  resource :pages

  resources :recipes do
    resources :comments
    collection do
      get :filter
    end
  end

  resources :sessions
  resources :users do
    resources :recipes
  end

  match 'about' => 'pages#about', via: :get
  match 'account' => 'users#show', via: :get
  match 'login' => 'sessions#new', via: :get, as: :login
  match 'logout' => 'sessions#destroy', via: :get, as: :logout
  match 'most_recent' => 'recipes#most_recent', via: :get
  match 'signup' => 'users#new', via: :get

  root to: 'recipes#index'
end
