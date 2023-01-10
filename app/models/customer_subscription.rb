class CustomerSubscription < ApplicationRecord
  enum status: { active: 1, cancelled: 0 }
  enum frequency: { weekly: 0, monthly: 1, yearly: 2 }

  belongs_to :customer
  belongs_to :subscription
end
