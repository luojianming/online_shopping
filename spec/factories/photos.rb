# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    image "MyString"
    color "MyString"
    product_id 1
  end
end
