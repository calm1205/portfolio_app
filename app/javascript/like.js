import { sidepop } from './sidepop.js';
document.addEventListener('turbolinks:load', () => {
    if (!document.location.pathname.match(/\/products\/\d+/)) return false;


    const DOMstrings = {
        likeEl:    ".like",
        productEl: "#cart_btn",
        HeartEl:   ".far.fa-heart",
        likedEl: ".fas.fa-heart"
    }


    const likesFunction = {
        createFunction: (e) => {
            e.stopPropagation();

            const productId = document.querySelector(DOMstrings.productEl).getAttribute('value');

            const XHR = new XMLHttpRequest();

            const hash = {
                product_id: productId,
                authenticity_token: document.getElementsByName('csrf-token')[0].content
            };
            const json = JSON.stringify(hash);

            const url = document.location.pathname + "/likes";

            XHR.open("post", url, true);
            XHR.setRequestHeader("Content-Type", "application/json");
            XHR.responseType = 'json';
            XHR.send(json);

            XHR.onload = () => {
                    document.querySelector(DOMstrings.HeartEl).remove();
                    const likeEl = document.querySelector(DOMstrings.likeEl);
                    likeEl.insertAdjacentHTML('afterbegin', `<i class="fas fa-heart" value="${XHR.response.id}"></i>`)
                    document.querySelector(DOMstrings.likedEl).addEventListener('click', likesFunction.deleteFunction);
                    sidepop('いいねしました。');
            }
            
        },
        deleteFunction: (e) => {
            const delLikedId = document.querySelector(DOMstrings.likedEl).getAttribute('value');

            const XHR = new XMLHttpRequest();

            const hash = {
                like_id: delLikedId,
                authenticity_token: document.getElementsByName('csrf-token')[0].content
            };
            const json = JSON.stringify(hash);

            const url = document.location.pathname + "/likes" + `/${delLikedId}`;

            XHR.open("delete", url, true);
            XHR.setRequestHeader("Content-Type", "application/json");
            XHR.responseType = 'json';
            XHR.send(json);

            XHR.onload = () => {
                document.querySelector(DOMstrings.likedEl).remove();
                const likeEl = document.querySelector(DOMstrings.likeEl);
                likeEl.insertAdjacentHTML('afterbegin', `<i class="far fa-heart"></i>`);
                document.querySelector(DOMstrings.HeartEl).addEventListener('click', likesFunction.createFunction);
                sidepop('いいねを解除しました。');
            }
        }
    }

    if (document.querySelector(DOMstrings.HeartEl)) {
        document.querySelector(DOMstrings.HeartEl).addEventListener('click', likesFunction.createFunction);
    }

    if (document.querySelector(DOMstrings.likedEl)) {
        document.querySelector(DOMstrings.likedEl).addEventListener('click', likesFunction.deleteFunction);
    }
});


