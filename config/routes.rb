QuotesApi::Application.routes.draw do
  resources :quotes do
    collection do
      get "random"
    end
  end

  root "quotes#index"
end
