// ========= モーダルウィンドウの関数 ============

// モーダル表示
export function open(){
  const modalDOM    = document.querySelector('.modal');
  modalDOM.classList.add('show');
  document.addEventListener('mousewheel', noScroll, { passive:false});
  document.addEventListener('touchmove', noScroll, { passive:false});
}

// モーダルウィンドウの閉じイベント仕込み
export function close(){
    const modalDOM  = document.querySelector('.modal');
    const closeDOM  = document.querySelector(`.modal__close--button`);
    const cancelDOM = document.querySelector(`.cancel`);
    closeDOM.addEventListener( 'click', ()=>{
      closeAction(modalDOM);
    });
    cancelDOM.addEventListener( 'click', ()=>{
      closeAction(modalDOM);
    });
};

function noScroll(e){
  e.preventDefault();
}

function closeAction(modalDOM){
  modalDOM.classList.remove('show');
  document.removeEventListener('mousewheel', noScroll, { passive:false});
  document.removeEventListener('touchmove', noScroll, { passive:false});
}