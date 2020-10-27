FactoryBot.define do
  # FactoryBot(ボット)をdefine定義する(作る)
    factory :comment do
      # factory :articleでcommentというボットを作ったことになる
      content { Faker::Lorem.characters(number: 300) }
      # Faker::Lorem.charactersで適当な文字列を書く。number: 300で300文字

    end
  end