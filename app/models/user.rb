# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 # ユーザーIDと投稿記事などを紐づけるため作業を行なっているフォルダー

  has_many :articles, dependent: :destroy
  # has_many :articlesでユーザーはたくさんの記事を持っているという意味。複数形なのでarticlesのsが大事
  # dependent: :destroyでユーザーが消されたら投稿の記事なども消すという意味。

  has_many :likes, dependent: :destroy
  # has_many :likes でいいねはたくさんのユーザーが行なっているという意味。複数形なのでlikesのsが大事
  # dependent: :destroyでユーザーが消されたら投稿の記事なども消すという意味。

  has_many :favorite_articles, through: :likes, source: :article
  # favorite_articlesは記事のことを表している。
  # sourceはlikesテーブルと紐づいているarticleの記事のみ取得
  # through: :likesでlikesテーブルを通してという意味
  # throughでlikesテーブルを通してarticleの記事のみ取得する。

  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  # 自分がフォローしている時のデータを持ってくる。
  # foreign_key: で外部キーは 'follower_id'を指定しますよという意味。
  # class_name: 'Relationship'でどのモデルのことを表現していうのか表している。

  has_many :followings, through: :following_relationships, source: :following
  # followingsはフォローしている人のことを表す
  # through: :following_relationshipsで中間テーブルのrelationshipsテーブルを通してという意味。
  # source: :followingでfollowingIDの取得

  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  # 自分がフォローされている時のデータを持ってくる。
  # foreign_key: で外部キーは 'following_id'を指定しますよという意味。
  # class_name: 'Relationship'でどのモデルのことを表現していうのか表している。

  has_many :followers, through: :follower_relationships, source: :follower
  # followersはフォローされている人のことを表す
  # through: :follower_relationshipsで中間テーブルのrelationshipsテーブルを通してという意味。
  # source: :followerでfollowerIDの取得

  has_one :profile, dependent: :destroy
  # has_oneは一つしかない場合に使う。profileもsはつけない。一つのプロフィールという意味。
  # dependent: :destroyでユーザーが消されたら投稿の記事なども消すという意味。

  delegate :age, :gender, to: :profile, allow_nil: true
  # delegateを使うと同じファイルの異なる内容の情報ををまとめて書くことができる。
  # profileの中のageとgenderを使えるようになる、allow_nil: trueでぼっち演算子をつけることができる。

  def has_written?(article)
    articles.exists?(id: article.id)
    # articles.exists?でarticleの中にレコードが存在するかしないか確認している。(id: article.id)で自分が登録したIDか聞いている。
    # articlesのshow.html.hamlでhas_written?(article)として呼び起こしている
  end

  def has_liked?(article)
    likes.exists?(article_id: article.id)
    # likes.exists?でいいねしている情報はあるか確認、IDはarticleのID
  end

  def display_name
    profile&.nickname || self.email.split('@').first
    # display_nameはprofile&.nicknameがあればそれを入れる、なければself.email.split('@').firstを入れる
    # &.はぼっち演算子といいprofileがnillじゃなかったらnicknameを入れるという意味。
  end

  def follow!(user)
    if user.is_a?(User)
      # is_a?でインスタンス変数か確認している。user.is_a?(User)でuserIDがインスタンス変数だったら。
      user_id = user.id
    else
      user_id = user
    end
    following_relationships.create!(following_id: user_id)
    # following_relationshipsのモデルでcreate!作りますよ。(following_id は user.id で取得するという意味。
  end

  def unfollow!(user)
    relation = following_relationships.find_by!(following_id: user.id)
    # followingでフォローしているIDの取得
    relation.destroy!
    # そのIDを消す
  end

  def has_followed?(user)
    following_relationships.exists?(following_id: user.id)
    # フォローしているかしていないかチェックしている
    # following_relationshipsで自分がフォローしている人の中に。exists?で いますか？。(following_id: user.id)フォローしているIDが
  end

  def prepare_profile
    profile || build_profile
    # profileがあったら左のprofileを表示ない場合は右の空のbuild_profileを表示。
  end

  def avatar_image
    if profile&.avatar&.attached?
      # profileが入っていない場合エラーになるため &. のぼっち演算子を入れている、profileのavaterがアップロードされている場合。
      profile.avatar
      # profileのavaterを表示
    else
      'default-avatar.png'
      # 画像がアップロードされていない場合はデフォルトの画像を表示
    end
  end
end
