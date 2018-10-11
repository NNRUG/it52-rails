class EventDecorator < Draper::Decorator
  delegate_all

  def participate_submit_title
    if past?
      h.t('.participate_past_submit_title')
    else
      h.t('.participate_submit_title')
    end
  end

  def cancel_participation_submit_title
    if past?
      h.t('.cancel_past_participation_submit_title')
    else
      h.t('.cancel_participation_submit_title')
    end
  end

  def rendered_description
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new autolink: true, filter_html: true, hard_wrap: true)
    markdown.render(object.description).html_safe
  end

  def simple_description
    h.h h.strip_tags(rendered_description)
  end

  def full_description
    rendered_description +
    h.content_tag(:p, link_to_time) +
    h.content_tag(:p, link_to_place)
  end

  def truncated_description(length = 80)
    text = h.strip_tags(rendered_description).squish
    h.truncate(text, length: length, separator: '.')
  end

  def summary
    [h.l(object.started_at), object.place, object.title].join(' – ')
  end

  def link_to_place
    base = "http://maps.yandex.ru/?text="
    h.link_to URI.encode(base + object.place), target: "_blank", itemprop: 'location', itemscope: true, itemtype: 'http://schema.org/Place' do
      h.content_tag(:span, object.place, itemprop: 'address') +
      h.content_tag(:span, object.place, itemprop: 'name', class: 'hidden')
    end
  end

  def link_to_time
    days_to_event = Date.current - object.started_at.to_date
    text = case days_to_event
      when 2 then 'Позавчера'
      when 1 then 'Вчера'
      when 0 then 'Сегодня'
      when -1 then 'Завтра'
      when -2 then 'Послезавтра'
    end

    text ||= h.localize(object.started_at, format: :date_without_year) if object.started_at.year == Time.current.year
    text ||= h.localize(object.started_at, format: :date)
    h.link_to h.event_path(object, format: :ics), class: 'event-date-inversed' do
      (h.content_tag :span, text, class: 'event-day') +
      (h.content_tag :span, h.localize(object.started_at, format: :time), class: 'event-time')
    end
  end
end
