Rails.application.routes.draw do

  resources :subscriptions
  resources :customers do
    resources :subscriptions
  end
end
