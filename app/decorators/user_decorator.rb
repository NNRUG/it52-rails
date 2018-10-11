class UserDecorator < Draper::Decorator
  delegate_all

  decorates_association :authentications

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def bio
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new autolink: true, filter_html: true, hard_wrap: true)
    markdown.render(object.bio || '').html_safe
  end

  def link_to_website
    if object.website?
      h.link_to object.website, object.website, target: :_blank
    end
  end
end
