# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#

# Articleファイルのデータを保存するためにあるファイル
# article.rbはarticleファイルのルールを決めるファイル
# validatesでルールを決めている。validationで色々なルールを調べると良い
# validateで独自のルールを決めている。validatesとvalidateは違うので注意

class Article < ApplicationRecord
  has_one_attached :eyecatch
  # 画像のアップロードのためのもの

  has_rich_text :content
  # contentに対して強化したエディターを渡すという意味

  validates :title, presence: true
  # titleがないと保存しない

  validates :title, length: { minimum: 2, maximum: 100 }
  validates :title, format: { with: /\A(?!\@)/ }
  
  # validateで独自のルールの内容についてprivateで書いている。この場合titleとcontentの内容が100文字以上ではなければいけないという意味。

  validates :content, presence: true
  # contentがないと保存しない

  has_many :comments, dependent: :destroy
  # has_many commentsでArticleがたくさんのコメントを持っているという意味。記事から見てコメントは複数あるため複数形にする。
  # dependent: :destroyでこの記事が削除されたらコメントも削除するという意味。

  has_many :likes, dependent: :destroy
  # has_many :likes でいいねはたくさんの記事に行なっているという意味。複数形なのでlikesのsが大事
  # dependent: :destroyでユーザーが消されたら投稿の記事なども消すという意味。

  belongs_to :user
  # belongs_to :userで記事はユーザーと紐づいているという意味。


end
