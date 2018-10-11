initYandexShare = (element) -> setTimeout (() -> Ya.share2(element)), 0


document.addEventListener 'turbolinks:load', ->
  if $('input#has_foreign_link').is(':checked')
    $('div#event_foreign_link_box').removeClass("hidden")
  $('input#has_foreign_link').on 'change', ->
    $('div#event_foreign_link_box').toggleClass('hidden')
    if !$(this).is(":checked")
      $('input#event_foreign_link').val('').attr('disable', true)
    else
      $('input#even_foreign_link').attr('disable', false)

  simplemdeId = document.querySelectorAll('.edit_event')[0]?.id
  simplemdeId ||= document.getElementById('new_event')?.id
  simplemdeId ||= document.getElementById('user_bio')?.id
  hasEditor = document.querySelectorAll('.editor-toolbar').length > 0
  if simplemdeId? and not hasEditor
    delete window.simpleMDE
    editorElement = document.getElementById("event_description")
    editorElement ||= document.getElementById("user_bio")
    window.simpleMDE = new SimpleMDE
      element: editorElement
      indentWithTabs: false
      promptURLs: true
      spellChecker: false
      autosave:
        enabled: true
        deplay: 3
        uniqueId: simplemdeId
      hideIcons: ['image']

$ ->
  $('.admin-info i.fas').tooltip()
  $('li.participant a').tooltip()

  if $('#uuid').length > 0
    uid = document.getElementById('uuid').dataset.userId
    ga?('set', '&uid', uid)

  $('input#event_started_at').datetimepicker
    locale: 'ru'
    stepping: 15
    showTodayButton: true
    sideBySide: true
    icons:
      time: "fas fa-clock-o"
      date: "fas fa-calendar-alt"
      up: "fas fa-arrow-up"
      down: "fas fa-arrow-down"

  shares = document.querySelectorAll('.ya-share2')
  sharesInitialized = document.querySelectorAll('.ya-share2_inited')

  if shares.length > 0 and sharesInitialized.length is 0
    Array.from(shares).forEach (element) -> initYandexShare(element)
