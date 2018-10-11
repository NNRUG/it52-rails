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

require 'rails_helper'

describe User do
  let(:user) { FactoryBot.create(:user) }
  let(:unsubscribed_user) { FactoryBot.create(:user, :unsubscribed) }

  it 'has default(member) role after creation' do
    expect(user.role).to eq 'member'
  end

  it { expect(user.subscription).to eq true }
  it { expect(unsubscribed_user.subscription).to eq false }
end
