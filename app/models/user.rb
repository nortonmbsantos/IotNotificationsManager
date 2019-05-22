class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates_uniqueness_of :auth_token

  def generate_auth_token!
    self.auth_token = Devise.friendly_token
  end
  
end
