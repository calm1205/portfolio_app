window.addEventListener('turbolinks:load', () => {
  if ( !document.querySelector(`.fa-search`)) { return false; }

  const searchBtn = document.querySelector(`.fa-search`);
  const searchDOM = document.querySelector(`.search`);
  const closeBtn = document.querySelector(`.close`);

  // メニュー出す時
  searchBtn.addEventListener('click', ()=> {
    searchDOM.style.top = '0';
    document.querySelector(`.search-text`).focus();
  });

  // メニューしまう時
  closeBtn.addEventListener(`click`, ()=> {
    searchDOM.style.top = '-100vh';
  });

});