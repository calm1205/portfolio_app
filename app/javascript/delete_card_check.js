import * as modal from './modal.js';
import { sidepop } from './sidepop.js';
document.addEventListener('turbolinks:load', () => {
  const deleteBtnDOM  = document.getElementById('delete-card-button');
  if ( !deleteBtnDOM){return false;}

  // 削除ポップアップの出現
  deleteBtnDOM.addEventListener( 'click', (e)=>{
    e.preventDefault();
    modal.open();
  });
  // モーダル閉じイベント仕込み
  modal.close();

  // 削除の実行
  const modalCommitDOM = document.querySelector(`.commit`);
  modalCommitDOM.addEventListener( 'click', () => {
    const XHR = new XMLHttpRequest();
    const url = "/card/destroy";    
    XHR.open("get", url, true);
    XHR.send();
    XHR.onload = () => {
      const response = JSON.parse(XHR.response);
      if (response.result){
        sidepop('カードが正常に削除されました。');
      }else{
        alert('カードの削除に失敗しました。')
      }
    }
    document.querySelector(`.modal`).classList.remove('show');
  });
});