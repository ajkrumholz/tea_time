require 'rails_helper'

RSpec.describe 'when a POST request is sent to /api/v1/customer_subscriptions' do
  let(:customer) { create :customer }
  let(:subscription) { create :subscription }

  describe 'happy path' do
    describe 'when all required fields are present' do
      it 'returns status code 201 and a serialized response' do
        body = {
          customer_id: customer.id,
          subscription_id: subscription.id,
          frequency: 'monthly'
        }

        post "/api/v1/customer_subscriptions", params: body
        expect(response.status).to be 201

        new_sub = CustomerSubscription.last
        expect(new_sub.customer_id).to eq customer.id
        expect(new_sub.subscription_id).to eq subscription.id

        result = JSON.parse(response.body, symbolize_names: true)
        expect(result).to be_a Hash

        data = result[:data]
        expect(data).to have_key(:id)
        expect(data[:id]).to be_a String
        expect(data).to have_key(:type)
        expect(data[:type]).to eq("customer_subscription")
        expect(data).to have_key(:attributes)

        attributes = data[:attributes]

        expect(attributes).to have_key(:customer_id)
        expect(attributes[:customer_id]).to be_an Integer
        expect(attributes).to have_key(:subscription_id)
        expect(attributes[:subscription_id]).to be_an Integer
        expect(attributes).to have_key(:frequency)
        expect(attributes[:frequency]).to be_a String
        expect(attributes).to have_key(:status)
        expect(attributes[:status]).to be_a String
      end
    end
  end

  describe 'sad path' do
    it 'if an attribute is incorrect' do
      body = {
        customer_id: customer.id,
        subscription_id: subscription.id,
        frequency: 'daily'
      }

      post "/api/v1/customer_subscriptions", params: body
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status 400
      expect(result).to have_key(:errors)
    end

    it 'if a customer doesnt exist' do
      body = {
        customer_id: 9999,
        subscription_id: subscription.id
      }

      post "/api/v1/customer_subscriptions", params: body

      result = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status 200
      expect(result).to have_key(:errors)
    end
  end
end