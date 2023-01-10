require 'rails_helper'

RSpec.describe CustomerSubscription do
  it { should belong_to :customer }
  it { should belong_to :subscription }

  it { should validate_presence_of :customer_id }
  it { should validate_presence_of :subscription_id }
  it { should validate_presence_of :frequency }
  it { should validate_presence_of :status }
end