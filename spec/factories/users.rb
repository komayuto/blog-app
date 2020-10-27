FactoryBot.define do
# FactoryBot(ボット)をdefine定義する(作る)
  factory :user do
    # factory :userでuserというボットを作ったことになる
    email { Faker::Internet.email}
    # user.rbのemailを読み込んでダミーデータを作っている
    password { 'password' }
    # user.rbのpasswordを読み込んでダミーデータを作っている

    trait :with_profile do
    # with_profileも一緒に作りますよという意味。違うファイルでwith_profileとするとこの中身が実行される。
      after :build do
        # after :buildで上のuserが作られたら実行する
        build(:profile, user: user)
        # userがbuildされたらprofileもbuildする
      end
    end
  end
end