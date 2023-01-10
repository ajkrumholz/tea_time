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
        expect(response).to be_successful
        result = JSON.parse(response.body, symbolize_names: true)

        data = result[:data]
        expect(data).to be_a Hash
        expect(data).to have_key :id
        expect(data).to have_key :type
        expect(data).to have_key :attributes

        attributes = data[:attributes]

        expect(attributes).to have_key :customer_id
        expect(attributes).to have_key :subscription_id
        expect(attributes).to have_key :frequency
        expect(attributes).to have_key :status
        expect(attributes[:status]).to eq("cancelled")
      end
    end

    describe 'sad path' do

    end
  end
end