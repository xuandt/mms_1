class Member < ActiveRecord::Base
  has_many :skills
  belongs_to :team
  has_many :member_projects
  has_many :projects, through: :member_projects
  before_save { self.email = email.downcase }
  attr_accessor :not_validate_password
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  before_save { email.downcase! }
  validates :password, presence: true, length: { minimum: 6 }, unless: :not_validate_password

  def Member.new_remember_token
    SecureRandom.urlsafe_base64
  end
  def Member.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    def create_remember_token
      self.remember_token = Member.digest(Member.new_remember_token)
    end
end