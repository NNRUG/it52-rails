require 'rails_helper'

describe MailchimpHooksController do
  describe 'POST #update_subscription' do
    let!(:subscribed_user) { FactoryBot.create(:user, :subscribed) }
    let!(:unsubscribed_user) { FactoryBot.create(:user, :unsubscribed) }

    let(:subscription_params) {
      { token: Figaro.env.mailchimp_hooks_token,
        type: 'unsubscribe',
        fired_at: '2014-12-08 18:20:30',
        data: {
          action: 'unsub',
          reason: 'manual',
          id:     '27b600e23a',
          email:  subscribed_user.email,
          email_type: 'html',
          ip_opt: '54.78.87.176',
          web_id: '125886081',
          list_id: '51957c4f07'
        }
      }
    }

    let(:unsubscription_params) { subscription_params.deep_merge(type: 'subscribe', data: { email: unsubscribed_user.email }) }

    it 'Mailchimp hook should unsubscribe user' do
      post :update_subscription, subscription_params
      subscribed_user.reload
      expect(subscribed_user.subscription).to eq false
    end

    it 'Mailchimp hook should unsubscribe user' do
      post :update_subscription, unsubscription_params
      unsubscribed_user.reload
      expect(subscribed_user.subscription).to eq true
    end
  end
end
