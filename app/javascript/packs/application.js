// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

require("trix")
require("@rails/actiontext")

import $ from 'jquery'
// import $ from 'jquery'はnode_modulesの中にあるjqueryから色々読み込む。jqueryを使うためのもの。読み込んだフィルをwebpackで解釈している。

import  axios from 'axios'
// axiosを使うためのコード

document.addEventListener('turbolinks:load', () => {
  $('.article_title').on('click', () => {
    axios.get('/')
    // axiosでrootの配下にgetリクエストを送る
      .then((response) => {
        // .thenで成功したら。responseを返す
        console.log(response)
        // console.logでresponseを確認する
      })
  })
})
// addEventListenerはイベントが発生したら関数の内容を行うという意味。
// turbolinks:load'でリロードのような長い動作なく表示を変更できたりする。railsのルール。
// DOMContentLoadedはページが表示されたら指定した内容を行うという意味。
// $('.article_title').on('click'でarticle_titleがクリックされたらという意味。onはaddEventListenerと同じような意味合い。
