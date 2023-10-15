class User < ApplicationRecord
  include Email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  USERNAME_REGEXP     = /\A[a-zA-Z0-9_.]+\z/
  MIN_USERNAME_LENGTH = 5
  MAX_USERNAME_LENGTH = 30
  MIN_PASSWORD_LENGTH = 8
  MAX_PASSWORD_LENGTH = ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
end
