import $ from 'jquery'
// import $ from 'jquery'はnode_modulesの中にあるjqueryから色々読み込む。jqueryを使うためのもの。読み込んだフィルをwebpackで解釈している。

import axios from 'axios'
// axiosを使うためのコード

import { csrfToken } from 'rails-ujs'
// postする際に勝手にpostされると困るためcsrfTokenに鍵を持たせるもの。
// 上のコードを入れる前にターミナルにて yarn add rails-ujs を実行する。

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()
// axiosでpost使う際にcsrfToken()に鍵を持たせるためのコード

const handleHeartDisplay = (hasLiked) => {
  if (hasLiked) {
    $('.active-heart').removeClass('hidden')
    // .active-heatのhiddenクラスを取り除く。removeClassでクラスを取り除く
  } else {
    $('.inactive-heart').removeClass('hidden')
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const dataset = $('#article-show').data()
  // datasetで記事のデータを取れるようにする
  const articleId = dataset.articleId
  axios.get(`/articles/${articleId}/like`)
  // axiosを/articles/${articleId}/like'でgetで表示
    .then((response) => {
      // .thenはgetで表示できたら。responseを返す
      const hasLiked = response.data.hasLiked
      // hasLikedのデータを返す
      handleHeartDisplay(hasLiked)
    })

    $('.inactive-heart').on('click', () => {
      // onは.inactive-heartのクラスのイベントの監視をしている。クリックされたら
      axios.post(`/articles/${articleId}/like`)
      // axiosを使う。postはlikeのいいねを示す。(`/articles/${articleId}/like`)のURLのこと。
        .then((response) => {
          // thenはpostで表示できたら。responseを返す
          if (response.data.status === 'ok') {
            // もしresponseのデータがokだったら
            $('.active-heart').removeClass('hidden')
            // removeClassでクラスのhiddenを表示
            $('.inactive-heart').addClass('hidden')
            // addClassでクラスのhiddenを消す
          }
        })
        .catch((e) => {
          // .catchはうまくいかなかったら。
          window.alert('Error')
          console.log(e)
        })
    })

    $('.active-heart').on('click', () => {
      // onは.active-heartのクラスのイベントの監視をしている。クリックされたら
      axios.delete(`/articles/${articleId}/like`)
      // axiosを使う。deleteはlikeのいいねの削除。(`/articles/${articleId}/like`)のURLのこと。
        .then((response) => {
          // thenはpostで表示できたら。responseを返す
          if (response.data.status === 'ok') {
            // もしresponseのデータがokだったら
            $('.active-heart').addClass('hidden')
            // addClassでクラスのhiddenを消す
            $('.inactive-heart').removeClass('hidden')
            // removeClassでクラスのhiddenを表示
          }
        })
        .catch((e) => {
          // .catchはうまくいかなかったら。
          window.alert('Error')
          console.log(e)
        })
    })
})