require 'rails_helper'

RSpec.describe 'when a POST request is sent to /subscriptions' do
  describe 'happy path' do
    describe 'when all required fields are present' do
      it 'returns status code 201 and a serialized response' do
        body = {
          title: '',
          price: 45.99,
          status: 'active',
          frequency: 'monthly',
          customer_id: 1,
          tea_ids: [1, 2]
        }

        post '/subscriptions', params: { body: body.to_json }

        result = JSON.parse(response.body, symbolize_names: true)
        expect(result).to be_a Hash
      end
    end
  end

  describe 'sad path' do

  end
end