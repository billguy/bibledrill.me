class User < ActiveRecord::Base

  acts_as_voter

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :timeoutable, :omniauthable, omniauth_providers: [:facebook]

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", micro: "32x32>" }, default_url: ":style/missing.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :highlights
  has_many :studies

  after_create :notify_admin

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      if image_url = auth.info.image
        user.avatar = URI.parse(image_url.gsub('http://','https://'))
      end
      user.skip_confirmation!
    end
  end

  def active?
    active
  end

  def username
    name.present? ? name : userid
  end

  def userid
    email.split('@').first
  end

  private

    def notify_admin
      UserMailer.new_user_notification(self).deliver_later
    end

end