FactoryBot.define do
  factory :item do
    # サンプルデータ準備
    item_name                {Faker::Games::Pokemon.name}
    description              {Faker::Lorem.sentence}
    category_id              {Faker::Number.between(from: 2, to: 11)}
    condition_id             {Faker::Number.between(from: 2, to: 7)}
    selling_price            {Faker::Number.between(from: 300, to: 9999999)}
    shipping_fee_category_id {Faker::Number.between(from: 2, to: 3)}
    state_province_id        {Faker::Number.between(from: 2, to: 48)}
    shipping_waiting_time_id {Faker::Number.between(from: 2, to: 4)}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image2.jpg'), filename: 'test_image2.jpg')
    end
  end
end
