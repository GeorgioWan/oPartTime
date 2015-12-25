class JobsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_jobs,     only: :index
  before_action :set_cities,   only: :index
  before_action :set_job,      only: [:edit, :update, :destroy]
  before_action :set_job_and_location, only: :show 
  before_action :set_value,    only: [:new,  :edit, :create, :update]
  helper_method :get_districts

  def index
    @at_city = params[:city] if params[:city]
    @at_district = params[:district] if params[:district]
    respond_to do |format|
      format.html
      format.js   {render 'jobs/jobslist/loadjobs' }
    end
  end

  def show
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
      redirect_to jobs_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @job.update job_params
      redirect_to @job
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_path
  end

  private
  def job_params
    params.require(:job).permit( :title, :url, :pay, :description, :company, :user_id, :city, :district)
  end

  def set_job
    @job = current_user.jobs.find(params[:id])
  end

  def set_jobs
    if params[:district]
      @jobs = Job.where(district: params[:district]).order("updated_at DESC")
    else
      @jobs = params[:city] ? Job.where(city: params[:city]).order("updated_at DESC") : Job.all.order("updated_at DESC")
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
      @button  ="張貼徵文"
    else
      @title   =@job.title
      @url     =@job.url
      @pay     =@job.pay
      @company =@job.company
      @city    =@job.city
      @district=@job.district
      @description =@job.description
      @button  ="修改張貼"
    end
  end
end
