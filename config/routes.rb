Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customer_subscriptions, only: [:create, :update]

      get '/customers/subscriptions', to: 'customers/subscriptions#index'
    end
  end
end
