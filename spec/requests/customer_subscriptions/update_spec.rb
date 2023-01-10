require 'rails_helper'

RSpec.describe 'updating a customer_subscription' do
  let(:customer) { create :customer }
  let(:subscription) { create :subscription }

  describe 'when a PATCH request is sent to /api/v1/customer_subscriptions/{id}' do
    describe 'happy path' do
      it 'allows the subscription status to change to cancelled without deleting the record' do
        customer.subscriptions << subscription
        new_sub = customer.customer_subscriptions.last

        body = { status: "cancelled" }
        patch "/api/v1/customer_subscriptions/#{new_sub.id}", params: body

        result = JSON.parse(response.body, symbolize_names: true)
        require 'pry'; binding.pry
      end
    end

    describe 'sad path' do

    end
  end
end