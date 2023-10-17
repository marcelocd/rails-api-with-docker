class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  include Email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  USERNAME_REGEXP     = /\A[a-zA-Z0-9_.]+\z/
  MIN_USERNAME_LENGTH = 5
  MAX_USERNAME_LENGTH = 30
  MIN_PASSWORD_LENGTH = 8
  MAX_PASSWORD_LENGTH = ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED

  validates :email, presence:   true,
                    uniqueness: { case_sensitive: false },
                    length:     { maximum:        MAX_EMAIL_LENGTH },
                    format:     { with:           EMAIL_REGEXP }
  validates :username, presence:   true,
                       uniqueness: { case_sensitive: false },
                       length:     { minimum:        MIN_USERNAME_LENGTH, maximum: MAX_USERNAME_LENGTH },
                       format:     { with:           USERNAME_REGEXP,     message: I18n.t('activerecord.errors.models.user.attributes.username.invalid_format') }

  validate :password_must_be_present
  validate :password_length_must_be_valid

  before_save :downcase_email
  before_save :downcase_username

  def self.find_for_database_authentication conditions = {}
    find_by(username: conditions[:email]) || find_by(email: conditions[:email])
  end

  private

  def password_must_be_present
    return if id.present?
    errors.add(:password, :blank) if password.blank?
  end

  def password_length_must_be_valid
    return if password.nil?
    if password.length < MIN_PASSWORD_LENGTH
      errors.add(:password, :too_short)
    elsif password.length > MAX_PASSWORD_LENGTH
      errors.add(:password, :too_long, maximum: MAX_PASSWORD_LENGTH)
    end
  end

  def downcase_email
    self.email = email.downcase if email.present?
  end

  def downcase_username
    self.username = username.downcase if username.present?
  end
end
