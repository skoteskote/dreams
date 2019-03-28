class User < ApplicationRecord
  extend AppSettings
  include RegistrationValidation
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [ :facebook, :saml ]

  has_many :tickets
  has_many :roles, -> { distinct("name") }
  has_many :memberships
  has_many :camps, through: :memberships
  has_many :favorites
  has_many :favorite_camps, through: :favorites, source: :camp
  has_many :created_camps, class_name: :Camp

  schema_validations whitelist: [:id, :created_at, :updated_at, :encrypted_password]

  def self.from_omniauth(auth)
    u = where(uid: auth.uid).first_or_create! do |user| # provider: auth.provider,
      user.email = auth.uid # .info.email TODO for supporting other things than keycloak
      user.password = Devise.friendly_token[0,20]
      user.grants = nil
    end
    # Omniauth doesn't know the keycloak schema
    info = auth.extra.raw_info
    u.name = info.all.fetch("urn:oid:2.5.4.42", []).fetch(0, "")
    # Last name : urn:oid:2.5.4.4

    for rolename in info.all["Role"]
      r = Role.where(name: rolename).first_or_create!
      if rolename.eql? "Borderland 2019 Membership" and u.grants.nil? # TODO multi event support, hacky
        u.grants = 10
      end
      u.roles << r
    end


    # avatars: get https://talk.theborderland.se/api/v1/profile/{username}
    # either loomio picture or gravatar
    u.save!
    u
  end
end
