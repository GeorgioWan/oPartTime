module JobHelper
  def btn_group_link_to text, path
    active = request.path == path ? :active : nil
    content_tag :li, link_to(text, path), class: active
  end
end
