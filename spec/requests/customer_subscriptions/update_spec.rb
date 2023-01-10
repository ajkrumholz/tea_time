require 'rails_helper'

RSpec.describe 'updating a customer_subscription' do
  let(:customer) { create :customer }
  let(:subscription) { create :subscription }

  describe 'when a PATCH request is sent to /api/v1/customer_subscriptions/{id}' do
    describe 'happy path' do
      it 'allows the subscription status to change to cancelled without deleting the record' do
        customer.subscriptions << subscription
        new_sub = customer.customer_subscriptions.last
        expect(new_sub.status).to eq('active')
        body = { status: "cancelled" }
        patch "/api/v1/customer_subscriptions/#{new_sub.id}", params: body
        expect(response).to be_successful
        result = JSON.parse(response.body, symbolize_names: true)
        new_sub.reload
        expect(new_sub.status).to eq('cancelled')
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
        expect(attributes[:status]).to eq('cancelled')
      end
    end

    describe 'sad path' do
      describe 'if status is passed incorrectly' do
        it 'returns a 304 and an error' do
          customer.subscriptions << subscription
          new_sub = customer.customer_subscriptions.last
          expect(new_sub.status).to eq('active')

          body = { status: "in progress" }
          patch "/api/v1/customer_subscriptions/#{new_sub.id}", params: body

          expect(response).to have_http_status 304

          new_sub.reload
          expect(new_sub.status).to eq('active')
        end
      end

      describe 'if record doesnt exist' do
        it 'returns an error code' do
          body = { status: "in progress" }
          patch "/api/v1/customer_subscriptions/9999", params: body

          expect(response).to have_http_status 204
        end
      end
    end
  end
end