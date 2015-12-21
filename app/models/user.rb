class User < ActiveRecord::Base
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
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

  def self.process_uri(uri)
    require 'open-uri'
    require 'open_uri_redirections'
    open(uri, :allow_redirections => :safe) do |r|
      r.base_uri.to_s
    end
  end


  def self.from_omniauth(auth)


    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name   # assuming the user model has a name
      if auth.info.image.present?
        avatar_url = process_uri(auth.info.image)
        user.update_attribute(:avatar, URI.parse(avatar_url))
      end
    end


  end



  has_attached_file :avatar, :styles => {  :thumb => "100x100#" }, :default_url => "/images/fetch.jpeg" #for resize avatar
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/ ###

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable ,  :omniauthable, :omniauth_providers => [:facebook]

end
