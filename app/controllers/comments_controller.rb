class CommentsController < ApplicationController
  def new
    article = Article.find(params[:article_id])
    # articleは空の箱、articleIDの取得をしている。
    @comment = article.comments.build
    # @commentは空の箱、article.comments.buildでarticleユーザーとcommentsが関連しているという意味。
  end

  def create
    article = Article.find(params[:article_id])
    # articleは空の箱、articleIDの取得をしている。
    @comment = article.comments.build(comment_params)
    # @commentは空の箱、articleでarticleIDの,comments.buildでcommentsと関連している、(comment_params)commentのID。
    if @comment.save
      # commentが更新されたら
      redirect_to article_path(article), notice: 'コメントを追加'
      # redirect_toでリンクに飛ばす、article_path(article)のリンクに、noticeで登録できたらコメントを追加を表示
    else
      flash.now[:error] = '更新できませんでした'
      # 更新されなかったら
      render :new
      # renderで表示、newを表示するという意味。
    end
  end

    # privateはデータを保存する際に使う
    private
    def comment_params
      params.require(:comment).permit(:content)
    # requireでcommentのキーを選択し、permitでcommentの中のこれだけは保存をすると言うのを選んでいる
    # ホームから投稿した際,contentの情報を抜き出してくると言う意味
    end
end
