class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :user_name, 
  uniqueness: true,
  length: {maximum: 10 },
  format: { with: /\A@[a-z0-9]+\z/, message: 'は@を先頭に小文字英数字で入力してください。' }

end
