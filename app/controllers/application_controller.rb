class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :guest_name, :set_login_cookie
  before_action :merge_favorite_job_from_cookie, if: :user_signed_in?
  before_action :prepare_meta_tags, if: "request.get?"
  
  helper_method :get_location

  protected

  ### Devise
  def after_sign_in_path_for(resource)  # Redirect to jobs when sign in
    jobs_path
  end
  
  def after_sign_out_path_for(resource_or_scope) # Redirect to jobs when sign out
    request.referrer
  end
  ###

  def guest_name
    @name = cookies[:name].nil? ? ["絕世美女","武林高手","丐幫成員","神奇寶貝大師","文學青年","小王子","短髮公主","鍵盤柯南","特級廚師","打工達人"].sample : cookies[:name]
    cookies[:name] = { :value => @name, :expires => 1.minute.from_now }
  end

  def set_login_cookie
    cookies[:is_login] = user_signed_in?
  end

  def merge_favorite_job_from_cookie
    jobIds = cookies[:favorite_jobs]
    if jobIds != nil
      JSON.parse(jobIds).each do |id|
        FavoriteJob.find_or_create_by user_id: current_user.id, job_id: id
      end
    end
    cookies.delete :favorite_jobs
  end

  # 替 job instance 新增 is_favorite? method 以判斷使用者是否已將該 job 加入最愛
  def set_jobs_favorite_flag(jobs)
    fids = get_favorite_job_ids
    jobs.each {|j| def j.is_favorite?; false end}
    jobs.to_a
      .clone
      .keep_if {|j| j.id.in? fids}
      .each {|j| def j.is_favorite?; true end}
  end

  def get_favorite_job_ids
    if user_signed_in?
      current_user.favorite_jobs.collect {|i| i.id}
    else
      c = cookies[:favorite_jobs]
      c == nil ? [] : JSON.parse(c).collect {|i| i.to_i}
    end
  end

  def get_location job
    TaiwanCity.list.each do |c|
      if c[1] == job.city
        @city=c[0]
      end
    end

    TaiwanCity.list(job.city).each do |d|
      if d[1] == job.district
        @district=d[0]
      end
    end

    return "#{@city}#{@district}"
  end
  
  def prepare_meta_tags(options={})

    site_name   = "oPartTime"
    title       = "兼差、短期打工、徵人才"
    description = "oPartTime 一起讓打工變得更美好！"
    current_url = request.url
    image       = current_url + view_context.image_path("landing/oPartTime_iPad_Mockups.png")

    # Let's prepare a nice set of defaults

    defaults = {
      site:        site_name,
      title:       title + " | " + site_name,
      image:       image,
      description: description,
      canonical:   current_url,
      keywords:    %w[oPartTime 兼差 徵人 打工 短期打工 臨時工],
      og:          {url: current_url,
                    site_name: site_name,
                    title: title + " | " + site_name,
                    image: image,
                    description: description,
                    type: 'website'}
    }

    options.reverse_merge!(defaults)
    
    set_meta_tags options

  end
  
  ### CanCan
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "抱歉，請您登入管理員帳號。"
  end
end
