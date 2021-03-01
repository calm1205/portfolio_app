// ========= モーダルウィンドウの関数 ============

// モーダル表示
export function open(){
  if (!document.querySelector('.modal')){ return false; }
  const modalDOM    = document.querySelector('.modal');
  modalDOM.classList.add('show');
  modalDOM.style.zIndex = '9999';
  document.addEventListener('mousewheel', noScroll, { passive:false});
  document.addEventListener('touchmove', noScroll, { passive:false});
}

// モーダルウィンドウの閉じイベント仕込み
export function close(){
  if (!document.querySelector('.modal')){ return false; }
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
  modalDOM.style.zIndex = '-1';
  document.removeEventListener('mousewheel', noScroll, { passive:false});
  document.removeEventListener('touchmove', noScroll, { passive:false});
}