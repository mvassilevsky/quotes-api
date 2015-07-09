QuotesApi::Application.routes.draw do
  resources :quotes
  resources :libraries do
    member do
      get "random"
    end
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root "libraries#index"
end
