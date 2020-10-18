class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false
      # ユーザーがいないとダメ
      t.string :nickname
      # 名前
      t.text :introduction
      # 自己紹介
      t.integer :gender
      # integerで整数。genderは性別
      t.date :birthday
      # 誕生日
      t.boolean :subscribed, default: false
      # メールを受信するか
      t.timestamps
    end
  end
end
