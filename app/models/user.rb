# frozen_string_literal: true

class User < ApplicationRecord
  include Roleable
  require "string"
  require "time_with_zone"

  USER_NAME_REGEX = /[^a-zéèàùïöüâêîôû\s-]/i

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many :access_grants,
           class_name: "Doorkeeper::AccessGrant",
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
           class_name: "Doorkeeper::AccessToken",
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  has_many :oauth_applications,
           class_name: "CustomApplication",
           as: :owner

  before_validation :cleanup_username

  validates :firstname, presence: true, length: {in: 2..30}
  validates :lastname, presence: true, length: {in: 2..30}

  private

    def cleanup_username
      self.firstname = firstname.gsub(USER_NAME_REGEX, "").to_s.patronize
      self.lastname = lastname.gsub(USER_NAME_REGEX, "").to_s.patronize
    end
end
