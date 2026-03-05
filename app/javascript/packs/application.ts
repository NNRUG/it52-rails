import * as Turbolinks from 'turbolinks';
import railsUjs from '@rails/ujs';

import { ForeignLinkSwitcher } from './helpers/foreign-link-switcher';
import { PaidEventSwitcher, ParticipantsLimitSwitcher } from './helpers/paid-event-switcher';
import { MdcInit } from './mdc/mdc-init';
import { YandexInit } from './yandex/yandex-init';

Turbolinks.start();
railsUjs.start();

function init(): void {
  const foreignLinkCheckbox = document.getElementById('has_foreign_link');
  if (foreignLinkCheckbox) ForeignLinkSwitcher.init();
  if (document.getElementById('event_paid_block')) PaidEventSwitcher.init();
  if (document.getElementById('event_participants_limit_block')) ParticipantsLimitSwitcher.init();
  MdcInit.init();
  YandexInit.init();

  let uuid = null;
  const uuidEl = document.getElementById('uuid');
  if (uuidEl) uuid = uuidEl.dataset.userId;
  if (typeof ga === 'function') {
    ga('set', '&uid', uuid);
    ga('set', 'location', location.href);
    ga('send', 'pageview');
  }

   const cookieBanner = document.getElementById('cookie-consent');
   if (cookieBanner) {
     const storageKey = 'it52_cookie_consent';
     let accepted = false;
     try {
       accepted = window.localStorage.getItem(storageKey) === '1';
     } catch (e) {
       accepted = false;
     }

     if (!accepted) {
       cookieBanner.classList.add('cookie-consent--visible');
     }

     const acceptButton = document.getElementById('cookie-consent-accept');
     if (acceptButton) {
       acceptButton.addEventListener('click', () => {
         try {
           window.localStorage.setItem(storageKey, '1');
         } catch (e) {
           // ignore
         }
         cookieBanner.classList.remove('cookie-consent--visible');
       });
     }
   }
}

document.addEventListener('turbolinks:load', init);
init();
