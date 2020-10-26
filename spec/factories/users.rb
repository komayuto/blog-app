FactoryBot.define do
# FactoryBot(ボット)をdefine定義する(作る)
  factory :user do
    # factory :userでuserというボットを作ったことになる
    email { Faker::Internet.email}
    # user.rbのemailを読み込んでダミーデータを作っている
    password { 'password' }
    # user.rbのpasswordを読み込んでダミーデータを作っている
  end
end