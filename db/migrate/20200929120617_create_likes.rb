# likesモデルは他対他なのでこのモデルは中間デーブルとなる

class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      # likesのテーブル、いいねを繰り返す、tに置き換える
      t.references :user, null: false
      # ユーザー情報がないとlike(いいね)ができない、referencesでlikesとuserをつなげている、null: falseで値がないとダメ。
      t.references :article, null: false
      # 記事の情報がないとlike(いいね)ができない、referencesでlikesとuserをつなげている、null: falseで値がないとダメ。
      t.timestamps
    end
  end
end
