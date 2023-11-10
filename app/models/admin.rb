class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:email]
         
  has_many :active_warning_notifications, class_name: "Notification", foreign_key: "visitor_id" #運営からの警告通知
  
end
