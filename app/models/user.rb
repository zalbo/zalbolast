class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
attr_accessor :login

  def self.find_first_by_auth_conditions(warden_conditions)
  conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  has_attached_file :avatar, :styles => { :medium => "300x300#>", :thumb => "100x100#" }, :default_url => "/images/fetch.jpeg" #for resize avatar
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/ ###

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
