class JobsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_jobs,  only: :index
  before_action :set_job,   only: [:show, :edit, :update, :destroy]
  before_action :set_value, only: [:new,  :edit, :create, :update]
  before_action :set_location, only: :show

  def index
    @cities= TaiwanCity.list
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
    @job=Job.new job_params
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
    @job = Job.find(params[:id])
  end

  def set_jobs
    @jobs = params[:city_id] ? Job.where(city: params[:city_id]).order("updated_at DESC") : Job.all.order("updated_at DESC")
    set_jobs_favorite_flag @jobs
  end

  def set_location
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
