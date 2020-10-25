class NotificationFromAdminJob < ApplicationJob
  queue_as :default
  # queue_asでどこのキューにに入れるか

  def perform(msg)
    # proformはjob.rbで絶対になくてはならないもの。railsルール。jobを実行したときにperform内が実行される。
    User.all.each do |user|
      # 全てのユーザーにメールを送信
      NotificationFromAdminMailer.notify(user, msg).deliver_later      
      # deliver_laterで非同期でメールを送信することができる
    end
  end
end