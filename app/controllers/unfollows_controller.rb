class UnfollowsController < ApplicationController

  before_action :authenticate_user!
  # ログインしていないと使えない。railsのルール。

  def create
    current_user.unfollow!(params[:account_id])
    # current_userでログインしているユーザー。unfollow!でフォローを外す。(params[:account_id])指定したアカウントのIDを
    redirect_to account_path(params[:account_id])
    # redirect_toで指定したリンクに飛ばす。account_path(params[:account_id])に
  end
end