class User < ActiveRecord::Base
  before_validation :downcase_email
  before_create :generate_authentication_token!

  has_many :products, dependent: :destroy
  validates :auth_token, uniqueness: true
  validates :email, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

  private
	def downcase_email
	  self.email = self.email.downcase if self.email.present?
	end
end
