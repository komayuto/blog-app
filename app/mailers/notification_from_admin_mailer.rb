class NotificationFromAdminMailer < ApplicationMailer
  def notify(user, msg)
    @msg = msg
    # インスタンス変数
    mail to: user.email, subject: 'お知らせ'
    # mail to:でメールを送る。選んだuserのemailに送る。subjectにメールのタイトルを入力する
  end
end