class UsersController < ApplicationController
  before_action :set_user, :set_jobs, except

  def show
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def set_jobs
    @jobs = @user.jobs.order("updated_at DESC")
  end
end
