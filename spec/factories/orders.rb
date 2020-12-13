require 'faker'
require 'factory_bot'

FactoryBot.define do
  factory :order do
    # f.customer_id { Customer.last.id }
    product_name { Faker::Commerce.product_name }
    product_count { Faker::Number.number(digits: 1) }
    association :customer
  end
end