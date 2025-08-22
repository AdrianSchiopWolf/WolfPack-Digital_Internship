FactoryBot.define do
  factory :product do
    name { Faker::Commerce.unique.product_name }
    price { Faker::Commerce.price(range: 0..100.0) }
    category { %w[Entrees Salads].sample }
  end
end