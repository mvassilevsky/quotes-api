QuotesApi::Application.routes.draw do
  get '/about' => "static_pages#about"

  resources :quotes do
    member do
      get "char_length"
    end
  end
  resources :libraries do
    member do
      get "random"
      get "iframe"
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
