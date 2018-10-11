class AuthenticationDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def link_to_social(css_classes = [])
    @css_classes = css_classes
    h.link_to object.link, class: css_class, target: :_blank do
      [icon, h.t("social.#{authentication.provider}.name")].join(' ').html_safe
    end
  end

  def link_to_destroy(css_classes = [])
    @css_classes = css_classes
    h.link_to h.my_authentication_path(object), method: :delete, class: css_class, data: { confirm: h.t('authentications.unlink') } do
      h.content_tag :i, '', class: "fas fa-times"
    end
  end

  def icon
    h.content_tag :i, '', class: "fab fa-#{object.provider}"
  end

  private

  def css_class
    return "btn btn-#{object.provider}" if @css_classes.empty?
    @css_classes.join(' ')
  end
end
