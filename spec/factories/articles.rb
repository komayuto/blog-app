FactoryBot.define do
  # FactoryBot(ボット)をdefine定義する(作る)
    factory :article do
      # factory :articleでarticleというボットを作ったことになる
      title { Faker::Lorem.characters(number: 10) }
      # Faker::Lorem.charactersで適当な文字列を書く。number: 10で10文字
      content { Faker::Lorem.characters(number: 300) }
      # Faker::Lorem.charactersで適当な文字列を書く。number: 300で300文字
    end
  end