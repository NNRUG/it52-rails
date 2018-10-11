module ApplicationHelper
  def render_editor?
    controller.controller_name == 'events' && !['index', 'show'].include?(controller.action_name)
  end

  def logo_class
    return 'user' if current_user&.member?
    return 'root' if current_user&.admin?
    ''
  end
end
