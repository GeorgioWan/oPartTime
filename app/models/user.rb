class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ### Association
  has_many :jobs
  has_many :favorite_job_list, class_name: "FavoriteJob"
  has_many :favorite_jobs, through: :favorite_job_list, source: :job

  ### Carrierwave
  mount_uploader :avatar, AvatarUploader

  ### Validate
  validates_format_of :twitter, :facebook, :googleplus, :website,
                      with: /(^$)|(^(http|https):\/\/[a-z0-9]+([\_\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix,
                      message: "URL 格式不正確"
end
