class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :api_key, uniqueness: true

  before_save :set_api_key

  private

  def set_api_key
    self.api_key = SecureRandom.base64.tr('+/=', 'Qrt')
  end
end
