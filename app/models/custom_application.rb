# frozen_string_literal: true

class CustomApplication < ApplicationRecord
  include ::Doorkeeper::Orm::ActiveRecord::Mixins::Application
end

# == Schema Information
#
# Table name: oauth_applications
#
#  id           :bigint           not null, primary key
#  confidential :boolean          default(TRUE), not null
#  name         :string(255)      not null
#  owner_type   :string(255)
#  redirect_uri :text(65535)      not null
#  scopes       :string(255)      default(""), not null
#  secret       :string(255)      not null
#  superapp     :boolean          default(FALSE), not null
#  uid          :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  owner_id     :integer
#
# Indexes
#
#  index_oauth_applications_on_owner_id_and_owner_type  (owner_id,owner_type)
#  index_oauth_applications_on_uid                      (uid) UNIQUE
#
