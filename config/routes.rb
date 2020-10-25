# routes.rbはURLを作るところ

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'articles#index'
  # root toで/を意味する。何もなけれはarticleのindexを表示すると言う意味

  resource :timeline, only: [:show]
  # タイムライン機能のURLの作成

  # resourcesとは色々なURLを作成する際に使う
  resources :articles do
    # resources :articles doでarticleのIDの下にURLを作る際に使う。例:id1の人の記事に何かコメントなどする場合id1のなかにURLを入れるというようなイメージ
    resources :comments, only: [:index, :new, :create]
    # resources :commentsでarticleIDのなかにcommentsのURLを作成している。

    resource :like, only: [:show, :create, :destroy]
    # resource :likeでarticleIDのなかにlikeのURLを作っている。
    # createの理由はlikesテーブルにレコードを作りいいねをしているためcreateになる
  end

  resources :accounts, only: [:show] do
  # 他のアカウントのプロフィールを見るためのもの
    resources :follows, only: [:create]
    # アカウントの中のフォローのURLの作成
    resources :unfollows, only: [:create]
    # アカウントの中のアカウントを消すためのURL
  end

  resource :profile, only: [:show, :edit, :update]
  # resource :profileでプロフィールのURLを作成。プロフィールはユーザーと紐付けられるのは一つなので単数。

  resources :favorites, only: [:index]
  # resource :favoritesでプロフィールのURLを作成。favorites（いいねだけを表示する画面）は複数表示するためsをつける。

end
