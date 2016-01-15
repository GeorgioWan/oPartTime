class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :set_jobs, only: :accepted
  layout "admin"
    
  def accepted
    authorize! :read, @job
  end
  
  def update
    @job = Job.find(params[:id])
    if @job.update job_params
      render nothing: true
    else
      render :accepted
    end
  end
  
  private
  def job_params
    params.permit( :accepted )
  end
  
  def set_jobs
    @jobs = Job.where( accepted: 'wait' ).order("updated_at DESC").page(params[:page]).per(10)
  end
end
