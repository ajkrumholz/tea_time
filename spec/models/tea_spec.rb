require 'rails_helper'

RSpec.describe Tea do
  it { should have_many subscription_teas }
  it { should have_many(subscriptions).through subscription_teas}
end