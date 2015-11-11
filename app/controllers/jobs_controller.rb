class JobsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_job,   only: [:show, :edit, :update, :destroy]
  before_action :set_value, only: [:new,  :edit, :create, :update]

  def index
    @jobs = Job.all
  end

  def show
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
    params.require(:job).permit( :title, :url, :pay, :location, :description, :company, :user_id)
  end

  def set_job
    @job = Job.find(params[:id])
  end

  def set_value
    if @job.nil?
      @title   ="徵才標題"
      @url     ="相關連結"
      @location="工作地點"
      @pay     ="時薪/日薪"
      @company ="徵人單位"
      @description = "徵人啟事敘述"
      @button  ="張貼徵文"
    else
      @title   =@job.title
      @url     =@job.url
      @location=@job.location
      @pay     =@job.pay
      @company =@job.company
      @description =@job.description
      @button  ="修改張貼"
    end
  end
end
