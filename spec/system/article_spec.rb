require 'rails_helper'
# rails_helperの設定を読み込んでいる

RSpec.describe 'Article', type: :system do
  # describeで何に対してテストを行いますか。Artickeについて。type: :systemでシステムスペックについて書きます。

  let!(:user) { create(:user) }
  # letはrspecにおいて変数を宣言する。この場合userが変数。create(:user)でfactoriesで作ったuserを読み込んでいる

  let!(:articles) { create_list(:article, 3, user: user) }
  # letはrspecにおいて変数を宣言する。create_listで複数createする。:article, 3で記事を三つ。user: userでユーザーはuserに紐づいている。

  it '記事一覧がひょうじされる' do
    # itは確認したいことを書く
    visit root_path
    # visitでブラウザを開きます。root_pathの
    articles.each do |article|
      # article記事を繰り返し複数確認する
      expect(page).to have_css('.card_title', text: article.title)
      # expectで確認する。pageでページの。to have_cssでその記事にcssは存在しているか、cssに対してクラスが存在しているか、そのクラスが持っているタグのテキストと一致しているか詳しく確認できる。article記事のタイトルの.card_titleのクラスのtextを
    end
  end

  it '記事の詳細を表示できる' do
    # itは確認したいことを書く
    visit root_path
    # visitでブラウザを開きます。root_pathの
    article = articles.first
    click_on article.title
    # articleのtitleをクリックしてくれる(click_onはaタグにしか使えない)

    expect(page).to have_css('.article_title', text: article.title)
    # expectで確認する。pageでページの。to have_cssでその記事にcssは存在しているか、cssに対してクラスが存在しているか、そのクラスが持っているタグのテキストと一致しているか詳しく確認できる。article記事のタイトルの.article_titleのクラスのtextを
    expect(page).to have_css('.article_content', text: article.content.to_plain_text)
    # expectで確認する。pageでページの。to have_cssでその記事にcssは存在しているか、cssに対してクラスが存在しているか、そのクラスが持っているタグのテキストと一致しているか詳しく確認できる。article記事のタイトルの.article_contentのクラスのtextを

  end
end