class AccountsController < ApplicationController
  def show
    @user = User.find(params[:id])
    # @userでユーザーのアカウントを取得できるようにした
    if @user == current_user
      # もし@userが自分のログインしているユーザーだったら(current_user)
      redirect_to profile_path
      # プロフィール画面に飛ばす
    end
  end
end