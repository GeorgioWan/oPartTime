class JobsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_jobs,     only: :index
  before_action :set_cities,   only: :index
  before_action :set_job,      only: [:edit, :update, :destroy]
  before_action :set_job_and_location, only: :show
  before_action :set_value,    only: [:new,  :edit, :create, :update]
  helper_method :get_districts

  def index
    # meta_tags
    @page_title = "找頭路"
    @page_description = "oPartTime 讓您更快速找到心目中的打工"
    
    @at_city = params[:city] if params[:city]
    @at_district = params[:district] if params[:district]
    
    respond_to do |format|
      format.html
      format.js   {render 'jobs/jobslist/loadjobs' }
    end
  end

  def show
    # meta_tags
    @page_title = @job.title + " | oPartTime"
    @page_description = "➧ 徵人單位：" + @job.company + "，地點：" + @city + @district + "，時薪：" + @job.pay + "元，詳述請點連結瞭解喲！by "  +  @job.user.name
    @page_image = @job.user.avatar_url(:fist)
    prepare_meta_tags( og: { title: @page_title,
                             description: @page_description,
                             image: @job.user.avatar_url(:fist)})
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @job=Job.new
  end

  def create
    @job=current_user.jobs.new job_params
    if @job.save
      redirect_to jobs_path, notice: "恭喜，我們會盡快作審核喔！ʕ ᓀ ᴥ ᓂ ʔ"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @job.update job_params
      redirect_to @job, notice: "您的貼文已更新，並送出審核囉！"
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_path, notice: "幫您移除貼文了！ʕ ﹒ ᴥ ﹒ ʔ"
  end

  private
  def job_params
    params.require(:job).permit( :title, :url, :pay, :description, :company, :user_id, :city, :district, :accepted )
  end

  def set_job
    @job = current_user.jobs.find(params[:id])
  end

  def set_jobs
    # Only show the jobs which were pass accepted
    @jobs = Job.where( accepted: "pass" )
    
    if params[:district]
      @jobs = @jobs.where(district: params[:district]).order("updated_at DESC")
    else
      @jobs = params[:city] ? @jobs.where(city: params[:city]).order("updated_at DESC") : @jobs.all.order("updated_at DESC")
    end
    
    # Only show the jobs updated in 15 days
    @jobs = @jobs.where( updated_at: (Time.now - 15.days)..Time.now ).page(params[:page])

    set_jobs_favorite_flag @jobs
  end

  def set_cities
    cities= TaiwanCity.list
    @cities= cities.keep_if{|c| !c.equal? cities.last}
  end

  def set_job_and_location
    @job = Job.find(params[:id])
    
    TaiwanCity.list.each do |c|
      if c[1] == @job.city
        @city=c[0]
      end
    end

    TaiwanCity.list(@job.city).each do |d|
      if d[1] == @job.district
        @district=d[0]
      end
    end
  end
  
  def get_districts city_id
    return TaiwanCity.list(city_id)
  end

  def set_value
    if @job.nil?
      @title   ="徵才標題"
      @url     ="相關連結"
      @pay     ="時薪"
      @company ="徵人單位"
      @city    ="工作縣市"
      @district="鄉鎮市區"
      @description = "徵人啟事敘述"
      @button  ="儲存並審核"
    else
      @title   =@job.title
      @url     =@job.url
      @pay     =@job.pay
      @company =@job.company
      @city    =@job.city
      @district=@job.district
      @description =@job.description
      @button  ="更新並審核"
    end
  end
end
