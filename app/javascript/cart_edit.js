window.addEventListener('turbolinks:load', function(){
  const paymentBtn = document.getElementById("payment");
  if (!paymentBtn) return false;

  // cartから商品の削除
  const dropBtns  = document.getElementsByClassName('drop')
  const dropArray = Array.from(dropBtns)
  dropArray.forEach(function(dropBtn){
    dropBtn.addEventListener( 'click', ()=> {
      const cart_index = dropBtn.parentNode.dataset.index;
      const XHR = new XMLHttpRequest();

      // ---------- ajax GET通信の時 ------------
      const url = "/carts/drop?id=" + cart_index;
      XHR.open("get", url, true);
      XHR.send();
      XHR.onload = () => {
        const response = JSON.parse(XHR.response);
        if (response.result){
          dropBtn.parentNode.remove();
          adjustment();
          alert("商品をカートから削除しました。")
        }else{
          alert("商品をカートから削除に失敗しました。")
        }
      }
    });
  });


  // cartの商品数の編集
  const plusBtns  = document.getElementsByClassName('quantity__plus');
  const plusArray = Array.from(plusBtns);
  plusArray.forEach(function(plusBtn){
    quantity_edit(plusBtn);
  });

  const minusBtns  = document.getElementsByClassName('quantity__minus');
  const minusArray = Array.from(minusBtns);
  minusArray.forEach(function(minusBtn){
    quantity_edit(minusBtn);
  });

  function quantity_edit(Btn){
    Btn.addEventListener('click', ()=> {
      const cart_index = Btn.parentNode.parentNode.dataset.index;
      let upOrDown   = 'plus'
      if (Btn.classList.contains('quantity__minus')) upOrDown = 'minus';

      // ---------- ajax POST通信の時 ------------
      const hash = {
        up_down: upOrDown,
        cart_id: cart_index,
        authenticity_token: document.getElementsByName('csrf-token')[0].content
      };
      const XHR = new XMLHttpRequest();
      const url = `/carts/quantity_edit`;
      XHR.open("post", url, true);
      XHR.setRequestHeader("Content-Type", "application/json");
      const json = JSON.stringify(hash);
      XHR.send(json);

      XHR.onload = () => {
        const response = JSON.parse(XHR.response);
        if (response.result){
          alert("カートの商品数を変更しました。")
          const quantityDOM = Btn.parentNode.querySelector('.quantity__value');
          if (upOrDown == 'plus'){
            quantityDOM.innerText = Number(quantityDOM.innerText) + 1;
          }else{
            quantityDOM.innerText = Number(quantityDOM.innerText) - 1;
            if ( quantityDOM.innerText == '0') Btn.parentNode.parentNode.remove();
          }
          adjustment();
        }else{
          alert("カートの商品数を変更できませんでした。")
        }
      }
    });
  }

  // cartの商品数が変更された時のviewの修正
  function adjustment(){
    const item_cardDOM = document.getElementsByClassName('cart__products__list--card');
    const item_kinds   = item_cardDOM.length;
    let   total_price  = 0;

    const item_cardArray = Array.from(item_cardDOM);
    item_cardArray.forEach(function(item_card){
      const priceDOM       = item_card.querySelector('.cart__products .price span');
      const totalDOM       = item_card.querySelector('.cart__products .total-price span');
      const quantityDOM    = item_card.querySelector('.quantity__value');
      const new_item_total = Number(priceDOM.innerText) * Number(quantityDOM.innerText);
      totalDOM.innerText   = new_item_total;
      total_price         += new_item_total;
    });

    const kindsDOM = document.querySelector('.cart__summary .quantity');
    const totalDOM = document.querySelector('.cart__summary .total_price span');

    kindsDOM.innerText = item_kinds;
    totalDOM.innerText = total_price;
  }
});