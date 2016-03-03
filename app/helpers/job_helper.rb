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
  
  ### 計算該 City 工作張貼數
  def jobs_count city_id
    if !city_id.blank?
      count = Job.where(city: city_id,  updated_at: (Time.now - 15.days)..Time.now ).count
      return count < 999 ? count : '999+'
    end
  end
  
  ### 計算該 District 工作張貼數
  def jobs_count_d district_id
    if !district_id.blank?
      count = Job.where(district: district_id,  updated_at: (Time.now - 15.days)..Time.now ).count
      return count < 999 ? count : '999+'
    end
  end
  
  ### City
  def city_tab_link_to text, path, city_id
    count = jobs_count(city_id)
    
    if path == "/"
      active = !@at_city ? :active : nil
      content_tag :li, link_to( trans_text(text), path), class: active
    else
      active = (@at_city == city_id ? :active : nil) if @at_city
      
      if count == 0
        content_tag :li, 
                    link_to( trans_text(text),
                            "##{city_id}",
                            data: {toggle: "pill"}, 
                            aria: {controls: city_id}), 
                    class: active
      else
        content_tag :li, 
                    link_to( (trans_text(text) + 
                              content_tag(:span, jobs_count(city_id), class: ["badge", "badge-city"])).html_safe, 
                              "##{city_id}",
                              data: {toggle: "pill"}, 
                              aria: {controls: city_id}), 
                    class: active
      end
    end
  end
  
  ### District
  def district_tab_link_to text, city_id, district_id
    count = jobs_count_d(district_id);
    
    active = (@at_district == district_id ? :active : nil) if @at_district
    
    if count == 0
      content_tag :li, link_to( trans_text(text), "/?city=#{city_id}&district=#{district_id}"), class: active
    else
      content_tag :li, 
                  link_to( (trans_text(text) + 
                            content_tag(:span, count, class: ["badge", "badge-city"])).html_safe, 
                            "/?city=#{city_id}&district=#{district_id}"), 
                  class: active
    end
  end
end
