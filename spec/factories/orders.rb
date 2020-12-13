require 'faker'
require 'factory_bot'

FactoryBot.define do
  customer = FactoryBot.create(:customer)
  factory :order do |f|
    f.customer_id { customer.id }
    f.product_name { Faker::Commerce.product_name }
    f.product_count { Faker::Number.number(digits: 1) }
  end
end