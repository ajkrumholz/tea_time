require 'rails_helper'

RSpec.describe Subscription do
  it { should have_many :customer_subscriptions }
  it { should have_many(:customers).through :customer_subscriptions }
end