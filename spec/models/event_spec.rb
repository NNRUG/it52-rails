# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  title        :string(255)      not null
#  created_at   :datetime
#  updated_at   :datetime
#  organizer_id :integer
#  published    :boolean          default(FALSE)
#  description  :text
#  started_at   :datetime
#  title_image  :string(255)
#  place        :string(255)
#  published_at :datetime
#  slug         :string(255)
#  location     :point
#

require 'rails_helper'

describe Event do
  describe 'should validate title' do
    let(:event) { FactoryBot.build :event, title: '' }
    it { expect(event).not_to be_valid }
  end

  describe 'should validate place' do
    let(:event) { FactoryBot.build :event, place: '' }
    it { expect(event).not_to be_valid }
  end

  describe 'should validate organizer' do
    let(:event) { FactoryBot.build :event, organizer: nil }
    it { expect(event).not_to be_valid }
  end
end
