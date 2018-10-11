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
    urls = auth['info']['urls']
    self.link = urls['GitHub'] || urls['Twitter'] || urls['Facebook'] || urls['Vkontakte'] || urls['Google'] if urls.present?
    self.link ||= auth['extra']['raw_info']['link']
    self.token = auth['credentials']['token']
    self.token_expires = auth['credentials']['expires_at']
    self
  end
end
