Rails.application.routes.draw do
  resources :customers, only: [] do
    resources :subscriptions, only: [:create]
  end
end
