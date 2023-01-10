require 'rails_helper'

RSpec.describe Customer do
  it { should have_many :customer_subscriptions }
  it { should have_many(:subscriptions).through :customer_subscriptions }

  it 'exists' do
    customer = create :customer
    expect(customer).to be_a described_class
  end

  # it 'can list all of its teas' do
  #   customer = create :customer

  #   subscription = create :subscription

  #   teas = create_list(:tea, 3)
  #   other_tea = create :tea
  #   subscription.teas << teas
  #   customer.subscriptions << subscription

  #   teas.each do |tea|
  #     expect(customer.teas).to include(tea)
  #   end

  #   expect(customer.teas).not_to include(other_tea)
  # end
end