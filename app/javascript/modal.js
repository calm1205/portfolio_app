// ========= モーダルウィンドウの関数 ============

// モーダル表示
export function open(){
  const modalDOM    = document.querySelector('.modal');
  modalDOM.classList.add('show');
  document.addEventListener('mousewheel', function(e){ e.preventDefault();}, { passive:false});
  document.addEventListener('touchmove', function(e){ e.preventDefault();}, { passive:false});
}

// モーダルウィンドウの閉じイベント仕込み
export function close(){
    const modalDOM  = document.querySelector('.modal');
    const closeDOM  = document.querySelector(`.modal__close--button`);
    const cancelDOM = document.querySelector(`.cancel`);
    closeDOM.addEventListener( 'click', ()=>{
      modalDOM.classList.remove('show');
    });
    cancelDOM.addEventListener( 'click', ()=>{
      modalDOM.classList.remove('show');
    });
};