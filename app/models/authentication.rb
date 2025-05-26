# frozen_string_literal: true

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

class Authentication < ApplicationRecord
  validates :uid, uniqueness: { scope: :provider }, presence: true
  validates :provider, presence: true

  belongs_to :user, touch: true

  def set_attributes_from_omniauth(auth)
    urls = auth.dig('info', 'urls')
    if urls.present?
      self.link = urls['GitHub'] || urls['Twitter'] || urls['Facebook'] || urls['Vkontakte'] || urls['Google'] || urls['Telegram']
    end
    raw_info = auth.dig('extra', 'raw_info')
    self.link ||= raw_info['link'] if raw_info.present? && raw_info.key?('link') && raw_info['link'].present?
    self.token = auth.dig('credentials', 'token')
    self.token_expires = auth.dig('credentials', 'expires_at')
    self
  end
end
