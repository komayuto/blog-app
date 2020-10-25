class CommentsController < ApplicationController
  def new
    article = Article.find(params[:article_id])
    # articleは空の箱、articleIDの取得をしている。
    @comment = article.comments.build
    # @commentは空の箱、article.comments.buildでarticleユーザーとcommentsが関連しているという意味。
  end

  def index
    article = Article.find(params[:article_id])
    # articleは空の箱、articleIDの取得をしている。
    comments = article.comments
    # articleIDを取得しコメントを作成
    render json: comments
    # comment_serializer.rbの内容を使えるようにしている
  end

  def create
    article = Article.find(params[:article_id])
    # articleは空の箱、articleIDの取得をしている。
    @comment = article.comments.build(comment_params)
    # @commentは空の箱、articleでarticleIDの,comments.buildでcommentsと関連している、(comment_params)commentのID。
    @comment.save!

    render json: @comment
    # comment_serializer.rbの内容を使えるようにしている
  end

    # privateはデータを保存する際に使う
    private
    def comment_params
      params.require(:comment).permit(:content)
    # requireでcommentのキーを選択し、permitでcommentの中のこれだけは保存をすると言うのを選んでいる
    # ホームから投稿した際,contentの情報を抜き出してくると言う意味
    end
end
