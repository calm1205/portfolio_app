// ========= ポップアップ表示の関数 ============
// 使い方
// ①使いたいjsファイルの一番最初でimport（以下を追記）
// import { sidepop } from './sidepop.js';

// ② sidepop('表示するテキスト'); で実行可能
// =========================================

export function sidepop(text){
  const popUps         = document.querySelectorAll('.sidepop');
  const popUpCount     = popUps.length;
  const display_height = popUpCount * 60 + 100;
  const timestamp      = Date.now();
  const html = `
    <div class="sidepop" style="top: ${display_height}px" data-time="${timestamp}">
      <span>
        ${text}
      </span>
    </div>`;
  
  // ポップアップの表示
  document.querySelector('body').insertAdjacentHTML('beforeend', html);

  // ポップアップの非表示
  const target = document.querySelector(`[data-time="${timestamp}"]`);
  setTimeout(sidedrop, 3000, target);
  setTimeout(deletepop, 4000, target);
};

function sidedrop(target){
  target.classList.add('unshown');
}

function deletepop(target){
  target.remove();
}
