# == Schema Information
#
# Table name: relationships
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  follower_id  :bigint           not null
#  following_id :bigint           not null
#
# Indexes
#
#  index_relationships_on_follower_id   (follower_id)
#  index_relationships_on_following_id  (following_id)
#
# Foreign Keys
#
#  fk_rails_...  (follower_id => users.id)
#  fk_rails_...  (following_id => users.id)
#
class Relationship < ApplicationRecord

  belongs_to :follower, class_name: 'User'
  # follower_IDと紐づいている。class_name: 'User'でクラス名の指定
  belongs_to :following, class_name: 'User'
  # following_IDと紐づいている。class_name: 'User'でクラス名の指定

  after_create :send_email
  # after_createでRelationshipが作成されたときsend_emailを実行。send_emailはprivateの内容

  private
  def send_email
    RelationshipMailer.new_follower(following, follower).deliver_later
    # 誰かがフォローされたときにsend_emailを実行する
    # deliver_nowは今すぐ送りましょうをいう意味
    # deliver_laterで非同期でメールを送信することができる
  end
  
end
