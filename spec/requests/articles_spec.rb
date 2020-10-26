require 'rails_helper'

RSpec.describe 'Articls', type: :request do

  let!(:user) { create(:user) }
  # letはrspecにおいて変数を宣言する。この場合userが変数。create(:user)でfactoriesで作ったuserを読み込んでいる

  let!(:articles) { create_list(:article, 3, user: user) }
  # letはrspecにおいて変数を宣言する。create_listで複数createする。:article, 3で記事を三つ。user: userでユーザーはuserに紐づいている。

  describe 'GET /articls' do
    # describeでこれについてのテストですよ。GETのArticlesに送る

    it '200ステータスが返って来る' do
      # itは確認したいこと書く
      get articles_path
      # articles_controllerにリクエストを送っている
      expect(response).to have_http_status(200)
      # responseはarticles_controllerにリクエストしてresponseされるという意味。expectは確認するためのもの。.to have_http_status(200)でresponseが 200htpp// になっているか確認している。
    end
  end

  describe 'POST /articls' do
    # describeでこれについてのテストですよ。POSTのArticlesに送る

    context 'ログインしている場合' do
      # contextで前提条件を提示する
      before do
        sign_in user
        # ログインしている
      end
      
      it '記事が保存されている' do
        # itは確認したいこと書く
        
        article_params = attributes_for(:article)
        # attributes_for(:article)でarticleのパラメーターを作っている(titleやcontentを勝手に作ってくれるということ)
        post articles_path({article: article_params})
        # articles_controllerにリクエストを送っている。({article: article_params})でarticleの記事にarticle_paramsの内容を入れる
        expect(response).to have_http_status(302)
        # responseはarticles_controllerにリクエストしてresponseされるという意味。expectは確認するためのもの。.to have_http_status(302)でresponseが302で返ってきているか確認している。
        expect(Article.last.title).to eq(article_params[:title])
        # expectで確認。Articleの記事の最後のタイトル。to eqでイコール(同じ)。articleのタイトルのデータと
        
        expect(Article.last.content.body.to_plain_text).to eq(article_params[:content])
        # expectで確認。Articleの記事の最後のcontent。to eqでイコール(同じ)。articleのコメントのデータと
      end
    end

    context 'ログインしていない場合' do
      # contextで前提条件の提示
      it 'ログイン画面に遷移する' do
        # itは確認したいことを書く
        article_params = attributes_for(:article)
        # attributes_for(:article)でarticleのパラメーターを作っている(titleやcontentを勝手に作ってくれるということ)
        post articles_path({article: article_params})
        # articles_controllerにリクエストを送っている。({article: article_params})でarticleの記事にarticle_paramsの内容を入れる
        expect(response).to redirect_to(new_user_session_path)
        # expect(response)でresponseを確認する。.to redirect_toでリンクに飛ぶ。new_user_session_pathに飛ぶ
      end
    end

  end
end
