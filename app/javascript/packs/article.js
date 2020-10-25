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

const handleCommentForm = () => {
  $('.show-comment-form').on('click', () => {
    // onは.show-comment-formのクラスのイベントの監視をしている。クリックされたら
    $('.show-comment-form').addClass('hidden')
    // .show-comment-formのクラスのhiddenをaddClassで消す
    $('.comment-text-area').removeClass('hidden')
    // .comment-text-areaのクラスのhiddenをremoveClassで付け足す(表示する)
  })
}

const appendNewComment = (comment) => {
  $('.comments-container').append(
    // appendはそのタグの中にHTMLを挿入するという意味。.comments-containerの中に。
    `<div class="article_comment"><p>${comment.content}</p></div>`
    // appendの挿入する内容
  )
}

document.addEventListener('DOMContentLoaded', () => {
  // DOMContentLoadedはリロードしないと更新できない。turbolinks:loadはリロードしなくても更新できる
  const dataset = $('#article-show').data()
  // datasetで記事のデータを取れるようにする
  const articleId = dataset.articleId

  axios.get(`/articles/${articleId}/comments`)
  // axiosを/articles/${articleId}/comments'でgetで表示
    .then((response) => {
      // .thenはgetで表示できたら。responseを返す
      const comments = response.data
      // commentsはdataをresponseしたのを取得する
      comments.forEach((comment) => {
      // forEachで一つ一つ取り出す。commentsをの内容を。commentで
        appendNewComment(comment)
        // コメント挿入の部分(内容は上の方でまとめている)
      })
    })

  handleCommentForm()
  // コメントのフォーム部分(内容は上の方でまとめている)

  $('.add-comment-button').on('click', () => {
    // onは.add-comment-buttonのクラスのイベントの監視をしている。クリックされたら
    const content = $(`#comment_content`).val()
    // #comment_contentを取得(コメントの入力部分のIDのことを指している)。
    if (!content) {
      // もしcontentがなければ
      window.alert('コメントを入力してください')
      // window.alertでアラートの表示
    } else {
      axios.post(`/articles/${articleId}/comments`, {
        // axiosをpostで表示/articles/${articleId}/commentsを
        comment: {content: content}
        // comments_controller.rbでコメントは comment: {content: 内容} このように表示するとしていたのでこのように入力をする
      })
        .then((res) => {
          // できたらresponseで返す
          const comment = res.data
          // responseのデータ
          appendNewComment(comment)
          // コメント挿入の部分(内容は上の方でまとめている)
          $(`#comment_content`).val('')
          // コメントの入力が終わったらコメント入力欄をからにするためのもの
        })
    }
  })

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