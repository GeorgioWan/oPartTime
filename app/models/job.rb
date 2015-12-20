class Job < ActiveRecord::Base
  ### Association
  belongs_to :user
  has_many :favorite_job_list, :class_name => "FavoriteJob"
  has_many :favorite_by, through: :favorite_job_list, source: :user

  ### Kaminari per page
  paginates_per 30

  ### Validate
  validates_presence_of   :title,       message: "您忘了斗大的標題！"
  validates_presence_of   :pay,         message: "工資是多少呢？"
  validates_presence_of   :description, message: "記得輸入打工的相關資訊或敘述喔！"
  validates_presence_of   :city,        message: "哪個縣市呢？"
  validates_presence_of   :district,    message: "哪個地區呢？"
  validates_uniqueness_of :title
  validates_length_of     [:title, :company], in: 3..15
  validates_numericality_of :pay, only_integer: true, message: "請填入整數"
  validates_format_of :url, with: /(^$)|(^(http|https):\/\/[a-z0-9]+([\_\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix,
                      message: "URL 格式不正確"
end
