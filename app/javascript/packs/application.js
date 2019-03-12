import "bootstrap";
import { pagepiler } from './pagepiler';
import { autocomplete } from '../plugins/init_autocomplete';
import { initLoader } from '../plugins/init_loader';
import { initTypewriter } from '../plugins/init_typewriter';
import { saved } from './saved';

pagepiler();
autocomplete();
initTypewriter();
initLoader();
saved();

// import "../views/creative_excuses/show.js.erb";
/*!
 * pagepiling.js 1.5.3
 *
 * https://github.com/alvarotrigo/pagePiling.js
 * @license MIT licensed
 *
 * Copyright (C) 2016 alvarotrigo.com - A project by Alvaro Trigo
 */
