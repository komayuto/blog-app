require 'rails_helper'

RSpec.describe 'Profile', type: :system do
  let!(:user) { create(:user, :with_profile) }

  context 'ログインしている場合' do
    # contextで前提条件の提示
    before do
      sign_in user
      # ログインしている
    end

    it '自分のプロフィールを確認できる' do
      # itは確認したいことを書く
      visit profile_path
      # visitでブラウザを開きます。profile_pathを
      expect(page).to have_css('.profilePage_user_displayName', text: user.profile.nickname)
      # expectで確認する。pageでページの。have_cssでその記事にcssは存在しているか、cssに対してクラスが存在しているか、そのクラスが持っているタグのテキストと一致しているか詳しく確認できる。profilePage_user_displayNameのクラスに。user.profile.nicknameでユーザのプロフィールにニックネームがあればいい。
    end
  end
end