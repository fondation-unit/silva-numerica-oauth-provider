# frozen_string_literal: true

class CustomApplication < ApplicationRecord
  include ::Doorkeeper::Orm::ActiveRecord::Mixins::AccessToken

  def superapp?
    return true
  end
end
