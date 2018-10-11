# == Schema Information
#
# Table name: event_participations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  event_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

# describe EventParticipation do
#   it { should validate_uniqueness_of(:user_id).scoped_to(:event_id) }
# end
