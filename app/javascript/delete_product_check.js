import * as modal from './modal.js';
document.addEventListener('turbolinks:load', () => {
  const deleteDOMs  = document.querySelectorAll(`.delete-button`);
  if ( !deleteDOMs.length ) { return false; }

  const deleteArray = Array.from(deleteDOMs);
  let   deleteId    = 0;

  // 削除ポップアップの出現
  deleteArray.forEach( function(deleteDOM) {
    deleteDOM.addEventListener( 'click', (e)=>{
      modal.open();
      deleteId = Number(e.target.dataset.index);
    });
  });
  // モーダル閉じイベント仕込み
  modal.close();

  // 削除の実行
  const modalCommitDOM = document.querySelector(`.commit`);
  modalCommitDOM.addEventListener( 'click', () => {

    const XHR = new XMLHttpRequest();
    const hash = {
      id: deleteId,
      authenticity_token: document.getElementsByName('csrf-token')[0].content
    };
    const json = JSON.stringify(hash);
    const url = "/products" + `/${deleteId}`;
    
    XHR.open("delete", url, true);
    XHR.setRequestHeader("Content-Type", "application/json");
    XHR.responseType = 'json';
    XHR.send(json);

    XHR.onload = () => {
      const productDOM = document.querySelector(`.delete-button[data-index="${deleteId}"]`).parentNode;
      productDOM.remove();
    }
    
  document.querySelector(`.modal`).classList.remove('show');
  });
});