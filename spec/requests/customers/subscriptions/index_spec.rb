require 'rails_helper'

RSpec.describe 'customer subscriptions index' do
  describe 'when a GET request is sent to /api/v1/customers/subscriptions' do
    describe 'happy path' do
      it 'returns a response containing active and cancelled subscriptions' do
        customer = create :customer
        subscriptions = create_list(:subscription, 3)

        subscriptions.each do |sub|
          teas = create_list(:tea, rand(2..5))
          sub.teas << teas
        end

        customer.subscriptions << subscriptions

        customer.customer_subscriptions.last.update(status: 'cancelled')

        get "/api/v1/customers/subscriptions", params: { customer_id: customer.id }
        expect(response).to be_successful

        result = JSON.parse(response.body, symbolize_names: true)
        expect(result).to be_a Hash
        expect(result).to have_key(:data)

        data = result[:data]
        expect(data).to be_an Array
        expect(data).not_to be_empty
        expect(data.size).to be 3

        first_sub = data.first
        expect(first_sub).to have_key(:id)
        expect(first_sub[:id]).to be_a String
        expect(first_sub).to have_key(:type)
        expect(first_sub[:type]).to be_a String
        expect(first_sub).to have_key(:attributes)
        expect(first_sub[:attributes]).to be_a Hash
        expect(first_sub).to have_key(:relationships)
        expect(first_sub[:relationships]).to be_a Hash

        attributes = first_sub[:attributes]
        expect(attributes).to have_key(:title)
        expect(attributes[:title]).to be_a String
        expect(attributes).to have_key(:price)
        expect(attributes[:price]).to be_a String
        expect(attributes).to have_key(:frequency)
        expect(attributes[:frequency]).to be_a String
        expect(['weekly', 'monthly', 'yearly']).to include(attributes[:frequency])
        expect(attributes).to have_key(:status)
        expect(attributes[:status]).to be_a String
        expect(['active', 'cancelled']).to include(attributes[:status])

        relationships = first_sub[:relationships]
        expect(relationships).to have_key(:teas)

        teas = relationships[:teas][:data]
        first_tea = teas.first

        expect(first_tea).to have_key(:id)
        expect(first_tea[:id]).to be_a String
        expect(first_tea).to have_key(:type)
        expect(first_tea[:type]).to eq 'tea'
      end
    end

    describe 'sad path' do
      describe 'if a customer has no subscriptions' do
        it 'returns an empty response' do
          customer = create :customer
      
          get "/api/v1/customers/subscriptions", params: { customer_id: customer.id}
          expect(response).to be_successful

          result = JSON.parse(response.body, symbolize_names: true)
          expect(result).to have_key(:data)
          expect(result[:data]).to be_an Array
          expect(result[:data]).to be_empty
        end
      end

      describe 'if a customer does not exist' do
        it 'returns an error message' do
          get '/api/v1/customers/subscriptions', params: { customer_id: 9999}
          expect(response).to be_successful

          result = JSON.parse(response.body, symbolize_names: true)
          expect(result).to have_key(:errors)
          expect(result[:errors]).to eq "Couldn't find Customer with 'id'=9999"
        end
      end
    end
  end
end