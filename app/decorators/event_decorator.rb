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
    h.link_to object.place, URI.encode(base + object.place), target: "_blank", "data-coords": "58.010259,56.234195"
  end

  def link_to_time
    h.link_to h.l(object.started_at, format: :date_time_full), h.event_path(object, :format =>:ics)
  end
end
