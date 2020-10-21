class RemoveContentFromArticles < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :content, :text
  end

  # def up
  #   remove_column :articles, :content
  # end
  # upはmigrateを実行したときに反映されるもの

  # def down
  #   add_column :articles, :content, :text
  # end
  # downはrollbackしたときに実行されるもの
end
