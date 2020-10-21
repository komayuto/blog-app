module ArticleDecorator
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

end