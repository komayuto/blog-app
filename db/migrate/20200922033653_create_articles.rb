class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :user, null:false
      # t.references :user, null:falseでarticlesにユーザー情報がないと絶対に更新できないという意味。(null:falseで絶対に値が入っていないとダメという規制をかけれる)
      t.string :title, null:false
      # tはテーブルstringは短い文を扱う際に使う
      t.text :content, null:false
      # textは長い分の際に扱う
      t.timestamps
      # timestampsはお決まり
    end
  end
end
