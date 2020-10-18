# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  content    :text             not null
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

  validates :title, presence: true
  # titleがないと保存しない

  validates :title, length: { minimum: 2, maximum: 100 }
  validates :title, format: { with: /\A(?!\@)/ }

  validates :content, presence: true
  # contentがないと保存しない

  validates :content, length: { minimum: 10 }
  validates :content, uniqueness: true

  validate :validate_title_and_content_length

  has_many :comments, dependent: :destroy
  # has_many commentsでArticleがたくさんのコメントを持っているという意味。記事から見てコメントは複数あるため複数形にする。
  # dependent: :destroyでこの記事が削除されたらコメントも削除するという意味。

  has_many :likes, dependent: :destroy
  # has_many :likes でいいねはたくさんの記事に行なっているという意味。複数形なのでlikesのsが大事
  # dependent: :destroyでユーザーが消されたら投稿の記事なども消すという意味。

  belongs_to :user
  # belongs_to :userで記事はユーザーと紐づいているという意味。

  def display_created_at
    I18n.l(self.created_at, format: :default)
  end
  # articleファイルの中で日付の表示を入れる際にdisplay_created_atと入れるだけで日付の表示ができるようにしている

  def author_name
    user.display_name
  end

  def like_count
    likes.count
    # いいねの数をカウントしてくれる
  end

  # validateで独自のルールの内容についてprivateで書いている。この場合titleとcontentの内容が100文字以上ではなければいけないという意味。
  private
  def validate_title_and_content_length
    char_count = self.title.length + self.content.length
    errors.add(:coutent, '100文字以上で') unless char_count > 100
  end
end
