const saved = () => {
  const hidden = document.getElementById('clickme');
  console.log(hidden);
  const button = document.querySelector('#fakebtn');
  if(button && hidden) {
    button.addEventListener('click', (e) => {
      if (document.getElementById('data').dataset.signed == 'true') {
        console.log("CLICKED")
        e.target.innerHTML = 'Saved!';
      }
      setTimeout(function() {
        console.log("HERE")
        hidden.click()
      }, 1000)
    });
  }
}

export { saved };



