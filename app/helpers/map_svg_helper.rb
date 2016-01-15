module MapSvgHelper
  def active_path id, city, drawpath
    
    city_path = "/?city=#{city}"
    if @at_city
      active = @at_city == city ? :active : nil
    end
    
    content_tag :path, "", d: drawpath, id: id, data: {city: city_path}, class: ["city-section", active]
  end
end
