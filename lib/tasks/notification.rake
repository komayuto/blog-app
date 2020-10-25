namespace :notification do
  desc '利用者にメールを送付する'

  task send_emails_from_admin: :environment do
    # environmentはいろんな設定を読み込んでいる。
    puts 'はじめての Rake task'
  end
end