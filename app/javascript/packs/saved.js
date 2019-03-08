
console.log("help");
const saved = () =>{
  $("button").click(function() {
    console.log("helpme")
    $(this).find("i").removeClass("far fa-heart").addClass("fas fa-heart");
  });

}

// const saved = () => {
//   const hidden = document.getElementById('clickme');
//   console.log(hidden);
//   const button = document.querySelector('#fakebtn');
//   if(button && hidden) {
//     button.addEventListener('click', (e) => {
//       if (document.getElementById('data').dataset.signed == 'true') {
//         e.target.innerHTML = 'Saving...!';

//       }
//       setTimeout(function() {
//         hidden.click()
//       }, 1000)

//     });
//   }
// }



// const saved = () => {
//   const button = document.querySelector("button");

//     button.addEventListener('click', (e) => {
//       e.preventDefault();
//       console.log("event");
//       e.removeClass("far fa-heart").addClass("fas fa-heart");
//     })

// }


// const saved = () => {
//   const button = document.querySelector('fa-minus-circle');
//   console.log("Hello");
//   if (button) {
//     button.addEventListener('click', (e) => {
//       e.preventDefault();
//       console.log("click");
//       // if (document.getElementById('data').dataset.signed == 'true') {
//       //   e.preventDefault();
//       //   $(this).next('ul').slideToggle('500');
//       //   $(this).find('i').toggleClass("fa-minus-circle fa-plus-circle");
//       // };
//     });
//   };
// }


export { saved };



