# routes.rbはURLを作るところ

require 'sidekiq/web'
# sidekiqをweb上で読み込むためのもの

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  # sidekiqでqueuesがどれくらい溜まっているのかweb上で確認するためのもの

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # development環境であれば/letter_openerのURLでLetterOpenerWebの内容が見れるようになるというもの。(送信したメールの確認のためのもの)

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'articles#index'
  # root toで/を意味する。何もなけれはarticleのindexを表示すると言う意味

  

  # resourcesとは色々なURLを作成する際に使う
  resources :articles 
    # resources :articles doでarticleのIDの下にURLを作る際に使う。例:id1の人の記事に何かコメントなどする場合id1のなかにURLを入れるというようなイメージ


  resources :accounts, only: [:show] do
  # 他のアカウントのプロフィールを見るためのもの
    resources :follows, only: [:create]
    # アカウントの中のフォローのURLの作成
    resources :unfollows, only: [:create]
    # アカウントの中のアカウントを消すためのURL
  end

  scope module: :apps do
    # scope moduleでコントローラーのみ変更。appsフォルダーについて

    resources :favorites, only: [:index]
    # resource :favoritesでプロフィールのURLを作成。favorites（いいねだけを表示する画面）は複数表示するためsをつける。

    resource :timeline, only: [:show]
    # タイムライン機能のURLの作成
    
    resource :profile, only: [:show, :edit, :update]
    # resource :profileでプロフィールのURLを作成。プロフィールはユーザーと紐付けられるのは一つなので単数。
  end

  namespace :api, defaults: {format: :json} do
    # namespaceURLもコントローラーも作成する。apiフォルダーについて変更。defaults{format: :json}でformat(htmlかjsonで表示するか)の指定できる

    scope '/articles/:article_id' do
      # scopeでURLのみ変更する。で先頭に/articles/:article_idを入れる

      resources :comments, only: [:index, :create]
      # resources :commentsでarticleIDのなかにcommentsのURLを作成している。
  
      resource :like, only: [:show, :create, :destroy]
      # resource :likeでarticleIDのなかにlikeのURLを作っている。
      # createの理由はlikesテーブルにレコードを作りいいねをしているためcreateになる
    end
  end
end
