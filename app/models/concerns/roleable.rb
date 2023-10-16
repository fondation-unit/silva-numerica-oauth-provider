# frozen_string_literal: true

module Roleable
  extend ActiveSupport::Concern

  included do
    scope :admins, -> { where(admin: true) }
    scope :customers, -> { where(customer: true) }
  end

  def admin?
    admin
  end

  def customer?
    !admin?
  end
end
