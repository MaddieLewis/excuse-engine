import Typewriter from 'typewriter-effect/dist/core';

const initTypewriter = () => {
  const excuses = ['FINDING EXCUSES...', 'LYING TO YOUR BOSS...', 'DECEIVING YOUR FRIENDS...', 'EATING YOUR HOMEWORK...', 'CREATING SIGNAL FAILURES...', 'SNOWING...', 'CLOSING ROADS...', 'APOLOGISING PROFUSELY...', 'PROFESSING LOVE FOR NIC CAGE...', 'NURSING LAST NIGHTS HANGOVER...', 'BEING RAVAGED BY WOLVES...', 'THE ALARM CLOCK NEVER WENT OFF...', 'GIT BLAMING...', 'FAKE IT TILL YOU RAKE IT...', 'GIT PUSH ORIGIN MASTER - OH NOO...', 'EATING YOUR COMPUTER...']
  if (document.getElementById('loading_excuse')) {

    const typewriter = new Typewriter('#loading_excuse', {
      loop: true,
    });
    excuses.forEach(excuse => {
      typewriter.typeString(excuse)
                .pauseFor(300)
                .deleteAll()
                .pauseFor(300)
                .start();
    });
  }
};

export { initTypewriter };
