class Member < ActiveRecord::Base
  has_many :skills
  belongs_to :team
  has_many :member_projects
  has_many :projects, through: :member_projects
  has_many :member_skills
  has_many :skills, through: :member_skills
  accepts_nested_attributes_for :member_skills, :reject_if => proc { |a| a[:skill_id].blank? }

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
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |member|
        csv << member.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Member.create! row.to_hash
    end
  end

  private
    def create_remember_token
      self.remember_token = Member.digest(Member.new_remember_token)
    end
end