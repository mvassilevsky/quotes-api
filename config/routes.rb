QuotesApi::Application.routes.draw do
  get '/about' => "static_pages#about"

  resources :quotes
  resources :libraries do
    member do
      get "random"
    end
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  authenticated :user do
    root to: "libraries#index", as: :authenticated_root
  end

  unauthenticated do
    root "static_pages#about"
  end
end
