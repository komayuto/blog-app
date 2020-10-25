class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  # メールをfrom@example.comのアドレスから送信しますよという意味。
  layout 'mailer'
  # viewの中のlayoutの中のmailerのフォルダーをテンプレートとして使いますよという意味。
end
