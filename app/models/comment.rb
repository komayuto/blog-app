# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  coment     :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_comments_on_user_id  (user_id)
#
class Comment < ApplicationRecord
  belongs_to :article
end
