class ArticlesController < ApplicationController
  # ArticlesControllerがApplicationControllerを継承していると言う意味(ApplicationControllerで書いてある内容を使える)

  before_action :set_article, only: [:show]
    # before_actionでarticles_controller.rb内で同じようなコードがある場合に使う。:set_articleの中に同じようなコードを入れてインスタンス変数で表示できるようにしている。only:[:show]でshowだけという意味。

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    # before_actionでarticles_controller.rb内で同じようなコードがある場合に使う。authenticate_user!はrailsのルールで全てのアプリがログインしていなければ使えないという意味。

  def index
    # 全ての画面の表示する際はrailsのルールでindexとしてあげなければならない
    # viewsのindexの設定
    @articles = Article.all
      # Article.allはArticleの中のデータを全て表うじするを言う意味
  end

  def show
  end

  def new
    @article = current_user.articles.build
      # @articleは空の箱、current_userでログインしているユーザーの値の取得、articles.buildでarticlesのユーザーとの関連性がある場合buildを使う。
  end

  def create
    @article = current_user.articles.build(article_params)
      # 上の文の@articleは空のインスタンスにデータを入れているだけ、current_userでログインしているユーザーと紐づける、articles.buildでarticlesのユーザーとの関連性がある場合buildを使う。

    if @article.save
      # @articleの情報を.saveで保存をしている
      redirect_to article_path(@article), notice: '保存できました。'
        # redirect_toで指定したリンクに飛ばすと言う意味でartidle_pathに飛ばすと言う意味。notice: 内容 で保存されたら内容を表示すると言う意味
    else
      flash.now[:error] = '保存に失敗しました。'
      render :new
        # render :newはnewの画面を表示すると言う意味。上の文では保存されなかったらnewの画面を表示という意味
    end
  end

  def edit
    @article = current_user.articles.find(params[:id])
      # @articleに空のデータを入れて、current_userでログインしているユーザーの取得、article.find(params[:id])でarticleのどのidのデータを編集するかという意味。
  end

  def update
    @article = current_user.articles.find(params[:id])
      # current_userでログインしているユーザーの取得、articles.find(params[:id])でidの指定という意味。

    if @article.update(article_params)
      # if @article.update(article_params)は保存できた場合という意味。

      redirect_to article_path(@article), notice: '更新できました'
        # redirect_toで指定したリンクに飛ばす。article_path(@article)でリンクの指定。noticeで更新できたら文字の表示という意味。
    else
      # flash.now[:error]でelseだったら更新できませんでしたと表示という意味。
      flash.now[:error] = '更新できませんでした'
      render :edit
        # render :editでeditファイルの表示(上の文更新できなかったらという意味)
    end
  end

    def destroy
      article = current_user.articles.find(params[:id])
        # current_userでログインしているユーザーの値の取得、articleに削除のデータを入れる。articles.find(params[:id])でidの取得。

      article.destroy!
        # article.destroy!でarticleのデータを削除するという意味。※destroyの最後に!をつけることで削除できなかった場合に例外を出すことができる。

      redirect_to root_path, notice: '削除しました'
        # redirect_toでリンクに飛ばす。root_pathがリンク。noticeで削除できた際に文字を表示する。
    end

  # privateはデータを保存する際に使う
  private
  def article_params
    # データ更新のためのもの
    params.require(:article).permit(:title, :content, :eyecatch)
  end
      # requireでarticleのキーを選択し、permitでarticleの中のこれだけは保存をすると言うのを選んでいる
      # ホームから投稿した際,:title, :content, :eyecatchの情報を抜き出してくると言う意味

  def set_article
    @article = Article.find(params[:id])
  end
    # articles_controller.rbの４行目で同じようなコードがある場合一つにまとめるように設定したがその内容が書いてある。

end
