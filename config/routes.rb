QuotesApi::Application.routes.draw do
  resources :libraries
  resources :libraries
  resources :quotes do
    collection do
      get "random"
    end
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root "quotes#index"
end
