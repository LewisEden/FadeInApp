class User < ApplicationRecord
  has_many :user_projects
  has_many :projects, through: :user_projects, dependent: :destroy
  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy
  
  validates :user_name, presence: true, length: { minimum: 4, maximum: 16 }	
  validates_uniqueness_of :user_name
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { medium: '152x152#' }, default_url: "https://s3.eu-west-2.amazonaws.com/fadein-assets/user.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
