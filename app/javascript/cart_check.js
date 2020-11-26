import * as modal from './modal.js';
window.addEventListener('turbolinks:load', function(){
  const payment = document.getElementById("payment");
  if (!payment) return false;

  // 決済確認開く
  payment.addEventListener("click", function(){
    modal.open();
    
    // クレジット登録してなければカード登録へ促す
    if ( document.querySelector('.card_number span').innerText == '----'){
      const mainContentDOM     = document.querySelector('.modal__content');
      const commitDOM          = document.querySelector('.commit')
      mainContentDOM.innerText = 'クレジットカードが登録されていません。\n登録しますか？'
      commitDOM.innerText      = '登録へ'

      commitDOM.addEventListener( 'click', ()=>{
        window.location.href = '/cards/new';
      });
    }
  })

  // モーダル閉じるイベント仕込み
  modal.close();

});