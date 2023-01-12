Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/customer_subscriptions', to: 'customer_subscriptions#create'

      patch '/customer_subscriptions', to: 'customer_subscriptions#update'

      get '/customers/subscriptions', to: 'customers/subscriptions#index'
    end
  end
end
