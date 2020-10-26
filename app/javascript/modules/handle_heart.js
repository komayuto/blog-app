import $ from 'jquery'
// import $ from 'jquery'はnode_modulesの中にあるjqueryから色々読み込む。jqueryを使うためのもの。読み込んだフィルをwebpackで解釈している。
import axios from 'modules/axios'
// modulesフォルダーの中のaxiosメソッドをimport(輸入)で持ってきている

const listenInactiveHeartEvent = (articleId) => {
  // listenInactiveHeartEventのメソッドが実行されたら配下のコードが実装される
 $('.inactive-heart').on('click', () => {
    // onは.inactive-heartのクラスのイベントの監視をしている。クリックされたら
    axios.post(`/api/articles/${articleId}/like`)
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
  }


  const listenActiveHeartEvent = (articleId) => {
    // listenActiveHeartEventのメソッドが実装されたら下のコードが実行される
    $('.active-heart').on('click', () => {
      // onは.active-heartのクラスのイベントの監視をしている。クリックされたら
      axios.delete(`/api/articles/${articleId}/like`)
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
  }

  export {
    // 下の二つのメソッドをexport(輸出する)する。article.jsで読み込めるようにしている
    listenInactiveHeartEvent,
    listenActiveHeartEvent
  }
  // exportの中は省略してかけているがバージョンによって省略できない