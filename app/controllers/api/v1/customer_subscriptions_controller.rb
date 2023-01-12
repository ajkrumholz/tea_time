class Api::V1::CustomerSubscriptionsController < ApplicationController
  def create
    customer = Customer.find(params[:customer_id])
    subscription = Subscription.find(params[:subscription_id])
    new_sub = CustomerSubscription.new(cust_sub_params)
    if new_sub.save
      hash = CustomerSubscriptionSerializer.new(new_sub)
      render json: hash, status: 201
    end
  rescue ArgumentError
    render json: { errors: ["Frequency is invalid"] }, status: 400
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }
  end
  
  def update
    sub = CustomerSubscription.find(params[:customer_subscription_id])
    sub.update(params.permit(:status, :frequency))
    if sub.save
      hash = CustomerSubscriptionSerializer.new(sub)
      render json: hash, status: 200
    end
  rescue ArgumentError
    render json: { errors: ["Status or Frequency is invalid, record not updated"] }, status: 304
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }
  end

  private
  
  def cust_sub_params
    params.permit(:customer_id, :subscription_id, :frequency)
  end
end
