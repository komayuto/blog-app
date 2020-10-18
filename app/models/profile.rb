# == Schema Information
#
# Table name: profiles
#
#  id           :bigint           not null, primary key
#  birthday     :date
#  gender       :integer
#  introduction :text
#  nickname     :string
#  subscribed   :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
class Profile < ApplicationRecord
  enum gender: { male: 0, female: 1, other: 2 }
  # enum gender:でgenderにどのような値を入れるか指定できる、{ male: 0, female: 1, other: 2 }男は0、女は1、その他は2としている。

  belongs_to :user
  # belongs_toで紐づけるという意味。プロフィールから見たらユーザーと紐づけるため上のようになる。

  has_one_attached :avatar
  # 画像をストレージにアップロードするためのコード

  def age
    return '不明' unless birthday.present?
    # birthdayが入力されていない場合不明と入力する
    years = Time.zone.now.year - birthday.year
    # Time.zone.now.yearで現在の時刻の年数という意味。birthday.yearで誕生日の年数。
    days = Time.zone.now.yday - birthday.yday
    # Time.zone.now.ydayで一年の始まりから何日経ったか、birthday.ydayで誕生日の日付

    if days < 0
      "#{years - 1}歳"
    else
      "#{years}歳"
    end
  end
end
