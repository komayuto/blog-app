class ProfilesController < ApplicationController

  before_action :authenticate_user!
  # before_actionでarticles_controller.rb内で同じようなコードがある場合に使う。authenticate_user!はrailsのルールで全てのアプリがログインしていなければ使えないという意味。

  def show
    @profile = current_user.profile
    # @profileは空箱、current_userでログインしているユーザーの値を取得。profileはuser.rbでhas_one :profileとしているためこのようになる
  end

  def edit
    @profile = current_user.prepare_profile
    # @profileは空箱、current_userでログインしているユーザーの値を取得。prepare_profileはuser.rbで設定している内容。
  end

  def update
    @profile = current_user.prepare_profile
    # @profileで空の箱、current_userでログインしているユーザーの値を取得、prepare_profileでuser.rbで設定した内容を入れている。

    @profile.assign_attributes(profile_params)
    # assign_attributesは合体させるという意味で、@profileとprofile_paramsの内容を合体させる。profile_paramsの値をこのインスタンスに入れてあげなければいけないためにやっている。

    if @profile.save
      # もし@profileが更新できたら
      redirect_to profile_path, notice: 'プロフィール更新'
      # redirect_toでリンクを飛ばす、profile_pathのリンク、notice:で更新できたら文字の表示。
    else
      flash.now[:error] = '更新できませんでした'
      # 更新できなかったら文字の表示
      render :edit
      # renderで表示、:editを
    end
  end

  # privateはデータの保存をするためにある
  private
  def profile_params
    params.require(:profile).permit(
      :nickname,
      :introduction,
      :gender,
      :birthday,
      :subscribed,
      :avatar
      # avatarは画像をストレージに保存するためのもの
    )
    # profile_params paramsでprofileのデータを取得、require(:profile)でprofileフォルダのキーを取得、permit()でカッコの中のデータを保存
  end
end
