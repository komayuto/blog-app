import axios from 'axios'
// axiosを使うためのコード

import { csrfToken } from 'rails-ujs'
// postする際に勝手にpostされると困るためcsrfTokenに鍵を持たせるもの。
// 上のコードを入れる前にターミナルにて yarn add rails-ujs を実行する。

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

export default axios
// defaultと書くとそれしか読み込まないという意味になるためimportする際に {} がいらなくなる。