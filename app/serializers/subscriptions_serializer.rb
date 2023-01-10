class SubscriptionsSerializer
  include JSONAPI::Serializer
  
  attributes :title,
             :price
  
  attribute :frequency do |object, params|
    sub = CustomerSubscription.find_by(
      subscription_id: object.id, 
      customer_id: params[:customer_id]
    )
    sub.frequency
  end

  attribute :status do |object, params|
    sub = CustomerSubscription.find_by(
      subscription_id: object.id, 
      customer_id: params[:customer_id]
    )
    sub.status
  end

  has_many :teas
end
