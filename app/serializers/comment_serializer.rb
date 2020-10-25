class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content
  # コメントのIDとコメントの内容(content)の取得をできるようにしている
  # comments_controller.rbのjsonでこの内容を使えるようにしている
end
