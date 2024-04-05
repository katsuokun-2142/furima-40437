FactoryBot.define do
  factory :order_shipping_information do
    address = Gimei.address

    zip_code            { "#{Faker::Number.leading_zero_number(digits: 3)}-#{Faker::Number.leading_zero_number(digits: 4)}" }
    state_province_id   { Faker::Number.between(from: 2, to: 48) }
    # city_town_village   { Faker::Address.city }
    city_town_village   { address.city.kanji }
    # street_address      { Faker::Address.street_address }
    street_address      { address.town.kanji }
    building_name       { Faker::Company.name }
    phone_number        { "0#{Faker::Number.between(from: 100_000_000, to: 9_999_999_999)}" }
    token               { Faker::Alphanumeric.alphanumeric(number: 30) }
  end
end
