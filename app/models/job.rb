class Job < ActiveRecord::Base
  ### Association
  belongs_to :user

  ### Validate
  validates_presence_of   :title, :description, :pay, :location
  validates_uniqueness_of :title
  validates_length_of     [:title, :company], in: 3..15
  validates_numericality_of :pay, only_integer: true, message: "請填入整數"
  validates_format_of :url, with: /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix,
                      message: "URL 格式不正確"
end
