require 'rails_helper'

RSpec.describe Customer do
  it { should have_many :customer_subscriptions }
  it { should have_many(:subscriptions).through :customer_subscriptions }

  
end