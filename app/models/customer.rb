class Customer < ApplicationRecord
  has_many :customer_subscriptions
  has_many :subscriptions, through: :customer_subscriptions

  def teas
    Tea.joins(subscriptions: :customers)
      .where(customer_subscriptions: {customer_id: self.id} )
      .distinct
  end
end
