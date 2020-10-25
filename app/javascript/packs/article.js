import $ from 'jquery'
// import $ from 'jquery'はnode_modulesの中にあるjqueryから色々読み込む。jqueryを使うためのもの。読み込んだフィルをwebpackで解釈している。
import axios from 'modules/axios'
// modulesフォルダーの中のaxiosメソッドをimport(輸入)で持ってきている

import {
  // import(輸入)で持ってくる
  listenInactiveHeartEvent,
  listenActiveHeartEvent
} from 'modules/handle_heart'
// modulesフォルダーのhandle_heartの中のlistenInactiveHeartEvent,listenActiveHeartEventの二つのメソッドを持ってくる

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
    
})

listenInactiveHeartEvent(articleId)
listenActiveHeartEvent(articleId)
// 上の二つはhandle_heart.jsの中のメソッドを使うための文。