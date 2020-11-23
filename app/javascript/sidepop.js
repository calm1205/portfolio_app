// ========= ポップアップ表示の関数 ============

// 使い方
// ①使いたいjsファイルの一番最初でimpot（以下を追記）
// import { sidepop } from './sidepop.js';

// ② sidepop('表示するテキスト'); で実行可能

// =========================================

export function sidepop(text){
  const popUps     = document.querySelectorAll('.sidepop');
  const popUpCount = popUps.length;
  const top        = popUpCount * 60 + 100;
  const timestamp  = Date.now();
  const html = `
    <div class="sidepop" style="top: ${top}px" data-time="${timestamp}">
      <span>
        ${text}
      </span>
    </div>`;
  document.querySelector('body').insertAdjacentHTML('beforeend', html);
  drop(document.querySelector(`[data-time="${timestamp}"]`));
};

// ポップアップの削除
function drop(target){
  sleep(3, sidedrop);
  sleep(4, deletepop);
  
  function sidedrop(){
    target.classList.add('unshown');
  }
  
  function deletepop(){
    target.remove();
  }
}

// sleep(停止時間、メソッド)
function sleep(sleepTime, func){
  let time = 0;
  const timer = setInterval( ()=> {
    time ++;
    if ( time > sleepTime) {
      clearInterval(timer);
      func();
    }
  }, 1000);
};
