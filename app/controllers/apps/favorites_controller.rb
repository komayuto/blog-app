class Apps::FavoritesController < Apps::ApplicationController

  def index
    @articles = current_user.favorite_articles
    # current_userでログインしているかを確認、favorite_articlesはuser.rbで定義したコードを表している。
  end
end
