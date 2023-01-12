class Api::V1::CustomerSubscriptionsController < ApplicationController
  def create
    customer = Customer.find(params[:customer_id])
    subscription = Subscription.find(params[:subscription_id])
    return duplicate_sub if sub_exists?
    new_sub = CustomerSubscription.new(cust_sub_params)
    if new_sub.save
      hash = CustomerSubscriptionSerializer.new(new_sub)
      render json: hash, status: 201
    end
  rescue ArgumentError => e
    rescue_error(e)
  rescue ActiveRecord::RecordNotFound => e
    rescue_error(e)
  end
  
  def update
    sub = CustomerSubscription.find(params[:customer_subscription_id])
    sub.update(params.permit(:status, :frequency))
    if sub.save
      hash = CustomerSubscriptionSerializer.new(sub)
      render json: hash, status: 200
    end
  rescue ArgumentError => e
    rescue_error(e)
  rescue ActiveRecord::RecordNotFound => e
    rescue_error(e)
  end

  private
  
  def cust_sub_params
    params.permit(:customer_id, :subscription_id, :frequency)
  end
 
  def rescue_error(e)
    render json: { errors: e.message }, status: 400
  end

  def duplicate_sub
    render json: { errors: "Customer subscription record exists, please update that record"}, status: 400
  end

  def sub_exists?
    sub = CustomerSubscription.where(subscription_id: params[:subscription_id], customer_id: params[:customer_id])
    !sub.empty?
  end
end
