FactoryBot.define do
  # FactoryBot(ボット)をdefine定義する(作る)
  factory :profile do
    # factory :profileでprofileというボットを作ったことになる
    nickname { Faker::Name.name }
    # Faker::Name適当な名前
    introduction { Faker::Lorem.characters(number: 100) }
    # Faker::Lorem適当な文字列
    gender { Profile.genders.keys.sample }
    # keysの中から。sampleでランダムで取り出す。
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
    # Faker::Date.birthday誕生日の適当な値
  end
end