# frozen_string_literal: true

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
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(autolink: true, filter_html: true, hard_wrap: true))
    markdown.render(object.description).html_safe
  end

  def simple_description
    h.h h.strip_tags(rendered_description)
  end

  def full_description
    rendered_description +
      h.content_tag(:p, l(event.started_at, format: :date_time_full)) +
      h.content_tag(:p, object.place)
  end

  def truncated_description(length = 80)
    text = h.strip_tags(rendered_description).squish
    h.truncate(text, length: length, separator: '.')
  end

  def summary
    [h.l(object.started_at), object.place, object.title].join(' – ')
  end

  def local_started_at
    helpers.l(object.started_at, format: :date_time_full).capitalize
  end

  def address_text
    [object.place, object.address_comment].select(&:present?).join(', ')
  end

  def human_time_distance
    days_to_event = Date.current - object.started_at.to_date
    case days_to_event
    when 2 then 'позавчера'
    when 1 then 'вчера'
    when 0 then 'сегодня'
    when -1 then 'завтра'
    when -2 then 'послезавтра'
    else time_distance
    end
  end

  def time_distance
    delta = object.started_at.to_date - Date.current
    delta_in_words = h.distance_of_time_in_words_to_now(object.started_at)
    if delta < 0
      "#{delta_in_words} назад"
    elsif delta <= 30
      "через #{delta_in_words}"
    elsif delta <= 45
      'через месяц'
    elsif delta <= 75
      'через пару месяцев'
    elsif delta <= 365
      "через #{delta_in_words}"
    else
      "ещё #{delta_in_words}"
    end
  end

  def link_to_place
    base = 'http://maps.yandex.ru/?text='
    h.link_to URI.encode(base + object.place), target: '_blank', itemprop: 'location', itemscope: true, itemtype: 'http://schema.org/Place', rel: 'noopener' do
      link_arr = [h.content_tag(:span, object.place, itemprop: 'address')]
      if object.address_comment.present?
        link_arr << h.content_tag(:span, object.address_comment, itemprop: 'name')
      end
      link_arr.join(', ').html_safe
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

    if object.started_at.year == Time.current.year
      text ||= h.localize(object.started_at, format: :date_without_year)
    end
    text ||= h.localize(object.started_at, format: :date)
    h.link_to h.event_path(object, format: :ics), class: 'event-date-inversed' do
      (h.content_tag :span, text, class: 'event-day') +
        (h.content_tag :span, h.localize(object.started_at, format: :time), class: 'event-time')
    end
  end
end
