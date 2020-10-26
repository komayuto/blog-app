require 'rails_helper'

RSpec.describe 'Api::Comments', type: :request do

  let!(:user) { create(:user) }
  # letはrspecにおいて変数を宣言する。この場合userが変数。create(:user)でfactoriesで作ったuserを読み込んでいる

  let!(:article) { create(:article, user: user) }
  # letはrspecにおいて変数を宣言する。createする。user: userでユーザーはuserに紐づいている。

  let!(:comments) { create_list(:comment, 3, article: article) }
  # letはrspecにおいて変数を宣言する。create_listで複数作成。commentを三つ。articleはarticle記事に紐づく。

  describe 'GET /api/comments' do
    # describeでこれについてのテストですよ。GETの /apiのcommentsについて
    it '200 Status' do
      # itは確認したいことを書く
      get api_comments_path(article_id: article.id)
      # getでapi_comments_pathのURLにリクエストを送る。記事のIDを指定するためにarticle_idはarticle.idとしている
      expect(response).to have_http_status(200)
      # responseはapiのcomments_controllerにリクエストしてresponseされるという意味。expectは確認するためのもの。.to have_http_status(200)でresponseが 200htpp// になっているか確認している。

      body = JSON.parse(response.body)
      # JSONのデータをbodyに渡している
      expect(body.length).to eq 3
      # bodyに3っつのデータがある確認。
      expect(body[0]['content']).to eq comments.first.content
      # bodyの0番目のcontentにダミーのfirst.contentがあるか
      expect(body[1]['content']).to eq comments.second.content
      # bodyの1番目のcontentにダミーのsecond.contentがあるか
      expect(body[2]['content']).to eq comments.third.content
      # bodyの2番目のcontentにダミーのthird.contentがあるか

    end
  end
end
