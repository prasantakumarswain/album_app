class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :albums
  has_many :images
  has_many :comments
  has_attached_file :profile_photo, :styles => { :small => "40x40>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :profile_photo, :content_type => /\Aimage\/.*\Z/
  validates :profile_photo, :presence => true
end
