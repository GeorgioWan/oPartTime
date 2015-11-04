class JobsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_job, only: [:show, :edit, :update, :delete]

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
    params.require(:job).permit( :title, :url, :pay, :location, :description, :company)
  end

  def set_job
    @job = Job.find(params[:id])
  end
end
