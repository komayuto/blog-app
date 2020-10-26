require 'rails_helper'

RSpec.describe Article, type: :model do

  let!(:user) { create(:user) }
    # letはrspecにおいて変数を宣言する。この場合userが変数。create(:user)でfactoriesで作ったuserを読み込んでいる

  context 'タイトルと内容が入力されていれている場合' do
    # contextで前提条件を提示する
    let!(:article) { build(:article, user: user) }
      # 記事のダミーデータを作成。保存できる場合はbuild。ユーザーはuserに紐づいている
      it '記事を保存できる' do
        # it'内容'doで ' ' の中に確認したいことを書く。doの中に確認する内容を書く
        
        expect(article).to be_valid
        # expectは確認するためのもの。be_validはこのメソッドが保存できる確認するためのもの。articleは記事のこと
      end
    end
      
  context 'タイトルの文字が１文字の場合' do
    # contextで前提条件を提示する

    let!(:article) { build(:article, title: Faker::Lorem.characters(number: 1), user: user) }
    # buildでarticle記事と関連性がある。title: Faker::Lorem.characters(number: 1)でタイトルを1文字に設定。ユーザーはuserに紐づいている

    before do
      article.save
      # article記事を保存
    end

    it '保存できない' do
      # it'内容'doで ' ' の中に確認したいことを書く。doの中に確認する内容を書く

      expect(article.errors.messages[:title][0]).to eq('は2文字以上で入力してください')
      # expectは確認するためのもの。be_validはこのメソッドが保存できる確認するためのもの。articleは記事のこと。errors.messages[:title]でタイトルに対してエラーのメッセージを取得。[0]は配列が０ということ。.to eqでイコールという意味で、エラーメッセージの内容と('内容')が同じだったら保存できない
    end
  end
end


# pending "add some examples to (or delete) #{__FILE__}"

# before do
# beforeの中に前提条件の内容を入れる。beforeはcontextを使っている場合は絶対使う。railsルール。

#  user = User.create!({
# ユーザーのダミーデータを作成
# email: 'test@example.com',
# password: 'password'
# })
# @article = user.articles.build({
# 記事のダミーデータを作成
# title: Faker::Lorem.characters(number: 10),
# Faker::Lorem.charactersで適当な文字列を書く。number: 10で10文字
# content: Faker::Lorem.characters(number: 300)
# Faker::Lorem.charactersで適当な文字列を書く。number: 300で300文字
# })
# end