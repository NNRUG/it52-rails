import * as Turbolinks from 'turbolinks';
import railsUjs from '@rails/ujs';

import { ForeignLinkSwitcher } from './helpers/foreign-link-switcher';
import { PaidEventSwitcher } from './helpers/paid-event-switcher';
import { MdcInit } from './mdc/mdc-init';
import { YandexInit } from './yandex/yandex-init';

Turbolinks.start();
railsUjs.start();

function init(): void {
  const foreignLinkCheckbox = document.getElementById('has_foreign_link');
  if (foreignLinkCheckbox) ForeignLinkSwitcher.init();
  if (document.getElementById('event_paid_block')) PaidEventSwitcher.init();
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
}

document.addEventListener('turbolinks:load', init);
init();
