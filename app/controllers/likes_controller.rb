class LikesController < ApplicationController
  before_action :authenticate_user!
  # before_actionでarticles_controller.rb内で同じようなコードがある場合に使う。authenticate_user!はrailsのルールで全てのアプリがログインしていなければ使えないという意味。

  def create
    article = Article.find(params[:article_id])
    # articleは空箱、articleのIDを取得している
    article.likes.create!(user_id: current_user.id)
    # 空のarticleにいいねを作る、!はできなかった場合エラーを出す、user_idはログインしているID
    redirect_to article_path(article)
    # できたらarticle_path(articleの記事)の場所に飛ばす
  end

  def destroy
    article = Article.find(params[:article_id])
    # articleは空箱、articleのIDを取得している
    like = article.likes.find_by!(user_id: current_user.id)
    # articleのIDに、likes.find_byでいいねされているか確認、IDはログインしている自分のID
    like.destroy!
    # likeを消す
    redirect_to article_path(article)
    # できたらarticle_path(articleの記事の場所)に飛ばす
  end
end
