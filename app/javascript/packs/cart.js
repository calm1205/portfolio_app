window.addEventListener('turbolinks:load', function(){
  const quantity_field = document.getElementById("product-quantity");
  if (!quantity_field) return false;
  const cart_btn = document.getElementById('cart_btn');
  cart_btn.addEventListener("click", function(e){
    // e.stopPropagation();
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

    XHR.onload = function(){
      if (XHR.response.status == 200){
        console.log("success")
      }
      else {
        console.log("errro");
      }
    }
  })
  // quantity_field.addEventListener("change", function(e){
  //   let quantity = this.value
  //   console.log("test!")
  // })
});