document.addEventListener('turbolinks:load', function () {
  if (document.location.pathname !== "/cards/new") return false;

  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  const regist_button = document.getElementById("card_submit");

  regist_button.addEventListener("click", function(e){
    e.preventDefault();

    const card = {
      number:    document.getElementById("card_number_form").value,
      exp_month: document.getElementById("exp_month_form").value,
      exp_year:  document.getElementById("exp_year_form").value,
      cvc:       document.getElementById("cvc_form").value
    };

    //------------- PAYJPにカード情報を送信 ----------------
    Payjp.createToken(card, (status, response) => { 

      if (status === 200){ 
        const XHR = new XMLHttpRequest();
        const hash = {
          payjp_token:        response.id,
          card_token:         response.card.id,
          authenticity_token: document.querySelector("input[name='authenticity_token']").value
        };
        const json = JSON.stringify(hash);

        const url = "/cards";
        XHR.open("post", url, true);
        XHR.setRequestHeader("Content-Type", "application/json");
        XHR.send(json);

        XHR.onload = () => {
          const response = JSON.parse(XHR.response);
          if (response.result){
            window.location.href = "/cards";
          }else{
            location.reload();
          }
        }

      } else{ 
        alert("カード情報が正しくありません。");
        regist_button.disabled = false;
      }
    });
  });
});