class User < ActiveRecord::Base
  has_many :date_plans
  has_many :restaurants, through: :date_plans
  has_many :events, through: :date_plan
  validates :picture, :first_name, :last_name, presence: true

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.picture = auth.info.image

      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
 end
end
