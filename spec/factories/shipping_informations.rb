FactoryBot.define do
  factory :shipping_information do
    zip_code            { Faker::Number.leading_zero_number(digits: 3) + '-' + Faker::Number.leading_zero_number(digits: 4) }
    state_province_id   { Faker::Number.between(from: 2, to: 48) }
    city_town_village   {Faker::Address.city}
    street_address      {Faker::Address.street_address}
    building_name       {Faker::Company.name}
    phone_number        {'0' + Faker::Number.between(from: 100000000, to: 9999999999)}
    association :order
  end
end
