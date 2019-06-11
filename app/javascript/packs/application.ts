declare var Ya;

import * as Turbolinks from 'turbolinks'
import Rails from 'rails-ujs'
import { ForeignLinkSwitcher } from './helpers/foreign-link-switcher'

import { MDCTopAppBar } from '@material/top-app-bar'
import { MDCRipple }    from '@material/ripple'
import { MDCList }      from '@material/list'
import { MDCDrawer }    from "@material/drawer"
import { MDCTabBar }    from '@material/tab-bar'
import { MDCMenu }      from '@material/menu'
import { MDCSelect }    from '@material/select'
import { MDCChipSet }     from '@material/chips'

Turbolinks.start()
Rails.start()

document.addEventListener('turbolinks:load', init)

function initYandexShare(element) {
  setTimeout(() => Ya.share2(element), 0);
}

function init(event: Event | any): void {
  const foreignLinkCheckbox = document.getElementById('has_foreign_link')
  if (!!foreignLinkCheckbox) new ForeignLinkSwitcher()

  let uuid = null
  const uuidEl = document.getElementById('uuid')
  if (uuidEl) uuid = uuidEl.dataset.userId
  if (typeof ga == 'function') {
    ga('set', '&uid', uuid)
    ga('set', 'location', (event as any).data.url)
    ga('send', 'pageview')
  }

  const shares = document.querySelectorAll('.ya-share2')
  const sharesInitialized = document.querySelectorAll('.ya-share2_inited')
  if (shares.length > 0 && sharesInitialized.length == 0) Array.from(shares).forEach(initYandexShare)

  // Material

  // Instantiation
  const topAppBarElement = document.querySelector('.mdc-top-app-bar')
  const topAppBar = new MDCTopAppBar(topAppBarElement)
  const drawer = MDCDrawer.attachTo(document.querySelector('.mdc-drawer'));
  const buttons = document.querySelectorAll('.mdc-button,.mdc-fab')
  const iconButtons = document.querySelectorAll('.mdc-icon-button')
  const lists = document.querySelectorAll('.mdc-list')
  const tabBars = document.querySelectorAll('.mdc-tab-bar')
  const menus = document.querySelectorAll('.mdc-menu')
  const selects = document.querySelectorAll('.mdc-select')
  const chips = document.querySelectorAll('.mdc-chip-set')

  topAppBar.setScrollTarget(document.getElementById('main-content'));
  topAppBar.listen('MDCTopAppBar:nav', () => drawer.open = !drawer.open)

  // Array.from(lists).forEach((list) => MDCList.attachTo(list))
  Array.from(buttons).forEach((button) => new MDCRipple(button))
  Array.from(iconButtons).forEach((button) => {
    const ripple = new MDCRipple(button)
    ripple.unbounded = true
  })
  Array.from(tabBars).forEach((tabBar) => new MDCTabBar(tabBar))
  Array.from(chips).forEach((chip) => new MDCChipSet(chip))
  // Array.from(menus).forEach((menu) => new MDCMenu(menu))
  // Array.from(selects).forEach((select) => new MDCSelect(select))

  const eventsKindMenu = new MDCSelect(document.querySelector('#events-select-menu'))
  eventsKindMenu.listen('MDCSelect:change', (event: CustomEvent) => {
    const menu = document.querySelector('#events-select-menu-list')
    const items = menu.querySelectorAll('.mdc-list-item')
    const selectedItem = items[event.detail.index] as HTMLElement
    console.log(menu, items, selectedItem)
    Turbolinks.visit(selectedItem.dataset.url)
  })
}

init({ data: { url: location.href }});
