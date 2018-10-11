# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(128)      default(""), not null
#  password_salt          :string(255)      default(""), not null
#  created_at             :datetime
#  updated_at             :datetime
#  reset_password_token   :string(255)
#  nickname               :string(255)      default("")
#  role                   :integer
#  first_name             :string(255)
#  last_name              :string(255)
#  bio                    :text
#  avatar_image           :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  slug                   :string(255)
#  website                :string(255)
#  subscription           :boolean
#

class UserSerializer < ActiveModel::Serializer
  cache key: 'user', expires_in: 3.hours
  attributes :id, :nickname, :full_name, :website, :bio, :avatar_url, :url

  has_many :authentications

  def avatar_url
    object.avatar_image.square_150.url
  end

  def url
    Rails.application.routes.url_helpers.user_url(object, host: Figaro.env.mailing_host)
  end
end
