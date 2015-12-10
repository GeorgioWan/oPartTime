module MapSvgHelper
  def active_path id, city, drawpath
    active = request.path == city ? :active : nil
    content_tag :path, "", d: drawpath, id: id, data: {city: city}, class: active
  end
end
