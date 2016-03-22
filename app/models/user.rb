class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:facebook]

  ### Association
  has_many :jobs
  has_many :favorite_job_list, class_name: "FavoriteJob"
  has_many :favorite_jobs, through: :favorite_job_list, source: :job
  
  ### omniauth facebook
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.id).first_or_create do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.email    = auth.info.email
      user.name     = auth.info.name
      user.facebook = auth.info.urls.Facebook
      user.password = Devise.friendly_token[0,20]
      user.remote_avatar_url   = auth.info.image
      user.skip_confirmation!
    end
  end

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
