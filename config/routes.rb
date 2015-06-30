QuotesApi::Application.routes.draw do
  resources :quotes

  root "quotes#index"
end
