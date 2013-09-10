# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :line_item do
    product_id 1
    cart_id 1
    quantity 1
    price "9.99"
  end
end
