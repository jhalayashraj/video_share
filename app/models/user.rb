class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable

  ## Relationships
  has_many :videos, dependent: :destroy

  ## Validations
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
end
