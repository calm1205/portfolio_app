export function sidepop(){

  console.log('test')
  let text = 'hello';
  const html = `
    <div class="sidepop">
      <span>
        ${text}
      </span>
    </div>`;

  document.querySelector('.nav').innerHTML += html;
  // sleep(3, deleteHTML);
  
  console.log(1111)
};

// function deleteHTML(){
//   document.querySelector('.sidepop').remove();
// }

// function sleep(sleepTime, func){
//   let time = 0;

//   const timer = setInterval( ()=> {
//     time ++;
//     if ( time > sleepTime) {
//       clearInterval(timer);
//       func();
//     }
//   }, 1000);
// };
