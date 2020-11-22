window.addEventListener('turbolinks:load', function(){
  const payment = document.getElementById("payment");
  if (!payment) return false;

  // モーダルウィンドウのDOMを取得
  const payModalDOM    = document.querySelector('.pay');
  const mainContentDOM = payModalDOM.querySelector('.pay__content');
  const commitDOM      = payModalDOM.querySelector('.commit')

  // 決済確認開く
  payment.addEventListener("click", function(){
    payModalDOM.classList.add('show');

    // クレジット登録してなければカード登録へ促す
    if ( document.querySelector('.card_number span').innerText == '----'){
      mainContentDOM.innerText = 'クレジットカードが登録されていません。\n登録しますか？'
      commitDOM.innerText      = '登録へ'

      commitDOM.addEventListener( 'click', ()=>{
        window.location.href = '/cards/new';
      });
    }
  })

  // 決済確認閉じる
  const closeDOM = payModalDOM.querySelector(`.pay__close--button`);
  const cancelDOM = payModalDOM.querySelector(`.cancel`);
  closeDOM.addEventListener( 'click', ()=>{
    payModalDOM.classList.remove('show');
  });
  cancelDOM.addEventListener( 'click', ()=>{
    payModalDOM.classList.remove('show');
  });
});