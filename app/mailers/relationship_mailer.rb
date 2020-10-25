class RelationshipMailer < ApplicationMailer
  def new_follower(user, follower)
    @user = user
    # インスタンス変数
    @follower = follower
    # インスタンス変数
    mail to: user.email, subject: ' 【お知らせ】フォローされました'
    # mail to:でメールを送る。選んだuserのemailに送る。subjectにメールのタイトルを入力する
  end
end