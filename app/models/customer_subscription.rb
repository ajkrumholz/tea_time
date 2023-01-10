class CustomerSubscription < ApplicationRecord
  enum status: { active: 1, cancelled: 0 }
  enum frequency: { weekly: 0, monthly: 1, yearly: 2 }

  belongs_to :customer
  belongs_to :subscription

  validates_presence_of :customer_id, 
                        :subscription_id, 
                        :frequency, 
                        :status
end
