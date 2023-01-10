require 'rails_helper'

RSpec.describe 'customer subscriptions index' do
  describe 'when a GET request is sent to /api/v1/customers/{id}/subscriptions' do
    describe 'happy path' do
      it 'returns a response containing active and cancelled subscriptions' do
        customer = create :customer
        subscriptions = create_list(:subscription, 3)

        customer.subscriptions << subscriptions

        customer.customer_subscriptions.last.update(status: 'cancelled')

        get "/api/v1/customers/#{customer.id}/subscriptions"
        expect(response).to be_successful

        result = JSON.parse(response.body, symbolize_names: true)
      end
    end
  end
end