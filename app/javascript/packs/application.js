import "bootstrap";
import 'pagepiling.js';
import { autocomplete } from '../plugins/init_autocomplete';
import { initLoader } from '../plugins/init_loader';
import { initTypewriter } from '../plugins/init_typewriter';
// import { saved } from './saved';

const initPagepiling = () => {
  if (document.getElementById('pagepiling')) {
   $(document).ready(function() {
      $('#pagepiling').pagepiling({
        menu: null,
          direction: 'vertical',
          verticalCentered: true,
          sectionsColor: [],
          scrollingSpeed: 700,
          easing: 'swing',
          loopBottom: false,
          loopTop: false,
          css3: true,
          navigation: {
              'textColor': '#000',
              'bulletsColor': '#000',
              'position': 'right',
              'tooltips': ['section1', 'section2', 'section3', 'section4']
          },
          normalScrollElements: '#map',
          normalScrollElementTouchThreshold: 5,
          touchSensitivity: 5,
          keyboardScrolling: true,
          sectionSelector: '.section',

        //events
        onLeave: function(index, nextIndex, direction){
          if (direction === "down") {
            document.querySelector(`.sec-${index}`).classList.add('hidden2');
            document.querySelector(`.sec-${nextIndex}`).classList.remove('hidden');
          } else
            document.querySelector(`.sec-${index}`).classList.add('hidden');
            document.querySelector(`.sec-${nextIndex}`).classList.remove('hidden2');
        },
        afterLoad: function(anchorLink, index){},
        afterRender: function(){},
      });
    });
 }
};

// pagepiler();
initPagepiling();
autocomplete();
initTypewriter();
initLoader();


// import "../views/creative_excuses/show.js.erb";
/*!
 * pagepiling.js 1.5.3
 *
 * https://github.com/alvarotrigo/pagePiling.js
 * @license MIT licensed
 *
 * Copyright (C) 2016 alvarotrigo.com - A project by Alvaro Trigo
 */
