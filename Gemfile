source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'pg', '>= 0.18', '< 2.0'
# データベースサーバーの立ち上げのための設定、本番環境のためのもの

gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker

# gem 'webpacker', '~> 4.3.0 自分で変更'
gem 'webpacker', '~> 4.0'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'annotate'
# データベースの状況をmodleにメモ書きとして残してくれるもの。
# bundle installをした後にターミナルにて rails g anotate:installをしなければならない。その後に rails db:migrateをする

gem 'active_decorator'
# active_decoratorファイルを使うための物

gem 'active_model_serializers'
# アクティブレコードに関するインスタンスをjsonに変換してくれる。
# rails g serializer 内容 をターミナルにて実行しファイルを作成する

gem 'better_errors'
gem 'binding_of_caller'
# 上の２文はエラー表示を分かりやすくするためのもの

gem 'devise'
# ログイン機能実装のためのもの

gem 'faker'

gem 'hamlit'
# hamlを使う使用するためのもの

gem 'aws-sdk-s3', require: false
# aws s3の設定のためのもの
# Use Active Storage variant

gem 'sidekiq'
# 非同期処理を簡単に行うためのアクティブジョブを使えるようにするためのもの

gem 'image_processing', '~> 1.2'
# 画像の編集などに使う。ターミナルにて brew install imagemagick を実行しておく

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'pry-byebug'
  # デベロッパーツール(バグなどを分かりやすくするためのツール)

  gem 'rubocop-rails'
# 文法のチェックをしてくれるツール(文法のルールは同じ階層に[.rubocop.yml]フォルダーを作ってそこに書く)

  gem 'dotenv-rails'
  # 環境変数を扱うためのもの

  gem 'rspec-rails'
  # テスト環境を作るためのもの

  gem 'factory_bot_rails'
  # 効率よくダミーデータを作るためのもの

end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '~> 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring

  gem 'erb2haml'
# erbフォルダーをhamlに変換するためのもの

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'letter_opener'
  # メールを開くためのgem
  gem 'letter_opener_web', '~> 1.0'
  # web上でメールの送信履歴など見れるようにする
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  # rubyによってブラウザを簡単に操作するためのもの

  gem 'selenium-webdriver'
  # rubyからブラウザを操作しやすくするもの

  # Easy installation and use of web drivers to run system tests with browsers

  gem 'webdrivers'
  # rubyからブラウザを操作しやすくするもの
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
