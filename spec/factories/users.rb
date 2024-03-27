FactoryBot.define do
  factory :user do
    japanese_user = Gimei.name

    nickname {Faker::Games::Pokemon.name}
    email {Faker::Internet.email}
    password {Faker::Internet.password(min_length: 6)+'1a'}
    password_confirmation {password}
    last_name {japanese_user.last.kanji}
    first_name {japanese_user.first.kanji}
    furi_last_name {japanese_user.last.katakana}
    furi_first_name {japanese_user.first.katakana}
    date_of_birth {Faker::Date.between(from: 30.years.ago, to: Date.today)}
  end
end