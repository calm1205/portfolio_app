document.addEventListener('turbolinks:load', () => {
  if ( !document.querySelector(`.pconsole`)){return false;}

  const deleteDOMs  = document.querySelectorAll(`.delete-button`);
  const deleteArray = Array.from(deleteDOMs);
  const deleteCheck = document.querySelector(`.delete`);
  let   deleteId    = 0;

  // 削除ポップアップの出現
  deleteArray.forEach( function(deleteDOM) {
    deleteDOM.addEventListener( 'click', (e)=>{
      deleteCheck.classList.add('show');
      deleteId = Number(e.target.dataset.index);
    });
  });

  // 削除ポップアップを閉じる。
  const closeDOM = deleteCheck.querySelector(`.delete__close--button`);
  const cancelDOM = deleteCheck.querySelector(`.cancel`);
  closeDOM.addEventListener( 'click', ()=>{
    deleteCheck.classList.remove('show');
  });
  cancelDOM.addEventListener( 'click', ()=>{
    deleteCheck.classList.remove('show');
  });

  // 削除の実行
  const deleteCommitDOM = document.querySelector(`.commit`);
  deleteCommitDOM.addEventListener( 'click', () => {

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
    deleteCheck.classList.remove('show');

  });
});