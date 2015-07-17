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

  root "static_pages#about"
end
