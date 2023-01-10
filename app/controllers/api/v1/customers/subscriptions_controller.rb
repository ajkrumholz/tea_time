class Api::V1::Customers::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])
    subscriptions = customer.subscriptions
    hash = SubscriptionsSerializer
      .new(subscriptions, params: { customer_id: customer.id})
    render json: hash
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }
  end
end