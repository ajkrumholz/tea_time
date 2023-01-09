require 'rails_helper'

RSpec.describe 'when a POST request is sent to /customer/{customer_id}/subscriptions' do
  describe 'happy path' do
    describe 'when all required fields are present' do
      it 'returns status code 201 and a serialized response' do
        customer = Customer.new(
          first_name = "Gary",
          last_name = "Busey",
          email = "test@gmail.com",
          address = "123 America St., Colorado City, CO"
        )
        
        body = {
          title: 'Mona Lisa Tea Wizards',
          price: 45.99,
          status: 'active',
          frequency: 'monthly',
          customer_id: 1,
          tea_ids: [1, 2]
        }

        post customer_subscriptions_path(1), params: { body: body }

        result = JSON.parse(response.body, symbolize_names: true)
        expect(result).to be_a Hash
      end
    end
  end

  describe 'sad path' do

  end
end