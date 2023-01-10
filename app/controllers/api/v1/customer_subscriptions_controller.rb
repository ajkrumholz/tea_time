class Api::V1::CustomerSubscriptionsController < ApplicationController
  def create
    new_sub = CustomerSubscription.new(cust_sub_params)
    if new_sub.save
      hash = CustomerSubscriptionSerializer.new(new_sub).serializable_hash
      render json: hash, status: 201
    else
      render json: { errors: new_sub.errors.full_messages }, status: 400
    end
  rescue ArgumentError
    render json: { errors: ["Frequency is invalid"] }, status: 400
  end

  private
  
  def cust_sub_params
    params.permit(:customer_id, :subscription_id, :frequency, :status)
  end
end
