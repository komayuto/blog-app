namespace :notification do
  desc '利用者にメールを送付する'

  task :send_emails_from_admin, ['msg'] => :environment do |task, args|
  # environmentはいろんな設定を読み込んでいる。argsは英語の引数をいう意味。
    msg = args['msg']
    if msg.present?
      # メッセージが存在したら
      NotificationFromAdminJob.perform_later(msg)
      # NotificationFromAdminJobのperform_laterの内容のメッセージを送信
    else
      puts '送信できませんでした。メッセージを入力してくてださい。ex. rails notification:send_emails_from_admin\[こんにちは\]'
    end
  end
end
