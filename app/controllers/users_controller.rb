class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_user, :set_jobs, only: :show
  helper_method :get_location

  def show
  end

  def edit_avatar
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update_avatar
    if current_user.update user_params
      redirect_to users_edit_avatar_path
    else
      render :edit_avatar
    end
  end

  private
  def user_params
    params.require(:user).permit(:avatar, :avatar_cache, :remove_avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_jobs
    @jobs = @user.jobs.order("updated_at DESC")
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
end
