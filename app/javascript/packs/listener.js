

const button = document.querySelector('#clickme');
// const audio = new Audio('bell.mp3');

button.addEventListener('click', (e) => {
  e.target.classList.add('disabled');
  e.target.innerText = 'Saved!';
  console.log("bla")
  // audio.play();
});
