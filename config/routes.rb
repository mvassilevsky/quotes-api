QuotesApi::Application.routes.draw do
  devise_for :users
  resources :quotes do
    collection do
      get "random"
    end
  end

  root "quotes#index"
end
