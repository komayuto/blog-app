class Apps::TimelinesController < Apps::ApplicationController

  def show
    user_ids = current_user.followings.pluck(:id)
    # current_userでログインしているユーザー。followingsでログインしているユーザーのフォローしているユーザー。pluck(:id)でフォローしているの全ての取得。
    @articles = Article.where(user_id: user_ids)
    # Article.whereで記事を探す。user_idがuser_idsで指定されているユーザーのIDを
  end

end