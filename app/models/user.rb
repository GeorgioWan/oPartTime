class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  ### Association
  has_many :jobs
  has_many :favorite_job_list, class_name: "FavoriteJob"
  has_many :favorite_jobs, through: :favorite_job_list, source: :job

  ### Carrierwave
  mount_uploader :avatar, AvatarUploader
  
  ### Friendly id
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  def normalize_friendly_id(input)
    "#{input.to_s.to_slug.normalize.to_s}"
  end
  
  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  ### Validate
  validates_format_of :twitter, :facebook, :googleplus, :website,
                      with: /(^$)|(^(http|https):\/\/[a-z0-9]+([\_\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix,
                      message: "URL 格式不正確"
end
