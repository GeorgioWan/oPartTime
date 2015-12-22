module JobHelper
  def trans_text text
    if text == "臺北市"
      return "台北"
    elsif text == "新北市"
      return "新北"
    else
      return text
    end
  end
  
  def jobs_count city_id
    if !city_id.blank?
      return Job.where(city: city_id).count if Job.where(city: city_id).count < 999
      return '999+'
    end
  end
  
  def btn_group_link_to text, path, city_id
    if path == "/" || path == "/jobs"
      active = request.path == path ? :active : nil
      content_tag :li, link_to( (trans_text(text) + content_tag(:span, jobs_count(city_id), class: ["badge", "badge-city"])).html_safe, path), class: active
    else
      active = request.path == "/"+city_id ? :active : nil
      content_tag :li, link_to( (trans_text(text) + content_tag(:span, jobs_count(city_id), class: ["badge", "badge-city"])).html_safe, path, class: "oPartTime-city", data: {cityid: city_id}), class: active
    end
  end
end
