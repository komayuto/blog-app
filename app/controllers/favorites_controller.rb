class FavoritesController < ApplicationController
  before_action :authenticate_user!
  # before_actionでarticles_controller.rb内で同じようなコードがある場合に使う。authenticate_user!はrailsのルールで全てのアプリがログインしていなければ使えないという意味。

  def index
    @articles = current_user.favorite_articles
    # current_userでログインしているかを確認、favorite_articlesはuser.rbで定義したコードを表している。
  end
end
