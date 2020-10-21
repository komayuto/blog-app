class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.references :following, null: false, foreign_key: { to_table: :users }
      # フォローされているuserと紐付ける。foreign_key: { to_table: :users }でusersテーブルと紐づいているという意味。
      t.references :follower, null: false, foreign_key: { to_table: :users }
      # フォローワーと紐付ける
      t.timestamps
    end
  end
end
