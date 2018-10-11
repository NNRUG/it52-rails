# == Schema Information
#
# Table name: authentications
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  provider      :string(255)      not null
#  uid           :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#  link          :string(255)
#  token         :string(255)
#  token_expires :datetime
#

class AuthenticationSerializer < ActiveModel::Serializer
  cache key: 'authentication', expires_in: 3.hours
  attributes :id, :provider, :link
end
