# frozen_string_literal: true

# 見た目に対して同じようなコードをまとめるためのファイル

module UserDecorator
  def display_name
    profile&.nickname || self.email.split('@').first
    # display_nameはprofile&.nicknameがあればそれを入れる、なければself.email.split('@').firstを入れる
    # &.はぼっち演算子といいprofileがnillじゃなかったらnicknameを入れるという意味。
  end

  def avatar_image
    if profile&.avatar&.attached?
      # profileが入っていない場合エラーになるため &. のぼっち演算子を入れている、profileのavaterがアップロードされている場合。
      profile.avatar
      # profileのavaterを表示
    else
      'default-avatar.png'
      # 画像がアップロードされていない場合はデフォルトの画像を表示
    end
  end

end
