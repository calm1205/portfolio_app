import { sidepop } from './sidepop.js';
document.addEventListener('turbolinks:load', function(){
  const quantity_field = document.getElementById("product-quantity");
  if (!quantity_field) return false;

  
  
  const cart_btn = document.getElementById('cart_btn');
  cart_btn.addEventListener("click", function(){
    setTimeout( console.log(222), 4000);
    const hash = {
      quantity: quantity_field.value,
      product_id: cart_btn.getAttribute('value'),
      authenticity_token: document.getElementsByName('csrf-token')[0].content
    };
    const XHR = new XMLHttpRequest();
    const url = `/carts/cart_in`;
    XHR.open("post", url, true);
    XHR.setRequestHeader("Content-Type", "application/json");
    const json = JSON.stringify(hash);
    XHR.send(json);

    XHR.onload = () => {
      const response = JSON.parse(XHR.response);
      if (response.result){
        sidepop('商品をカートに入れることができました。');
      }else{
        alert("商品をカートに入れることができませんでした。");
      }
    }

  })
});