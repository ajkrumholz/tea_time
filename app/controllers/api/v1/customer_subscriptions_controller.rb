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
  
  def update
    sub = CustomerSubscription.find(params[:id])
    sub.update(params.permit(:status, :frequency))
    if sub.save
      hash = CustomerSubscriptionSerializer.new(sub).serializable_hash
      render json: hash, status: 200
    end
  rescue ArgumentError
    render json: { errors: ["Status or Frequency is invalid, record not updated"] }, status: 304
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ["Record not found, check the ID"]}, status: 204
  end

  private
  
  def cust_sub_params
    params.permit(:customer_id, :subscription_id, :frequency)
  end
end
