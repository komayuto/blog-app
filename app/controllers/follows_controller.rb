class FollowsController < ApplicationController

  before_action :authenticate_user!
  # ログインしていなければ使えない。railsのルール。

  def create
    current_user.follow!(params[:account_id])
    # current_userでログインしているユーザー。follow!でフォローをする。(params[:account_id])でアカウントのID、他の人のIDを。
    redirect_to account_path(params[:account_id])
    # redirect_toで選択したリンクに飛ばす。accout_path(params[:accout_id])で選択されているアカウントのIDに
  end

end
