require 'rails_helper'

describe EventsController do
  context 'POST create' do
    let(:event_attrs) { FactoryBot.attributes_for(:event) }
    let(:user) { FactoryBot.create :user }
    let(:admin) { FactoryBot.create :admin }

    context 'when user is anonymous' do
      it 'unlogged user cannot create event' do
        expect(post :create, event: event_attrs).to redirect_to root_path
      end

      it { expect(get :new).to redirect_to new_user_session_path }
    end

    context 'when user is logged in' do
      before { sign_in user }
      it { expect { post :create, event: event_attrs }.to change(Event, :count).by 1 }
    end

    context 'when admin is logged in' do
      let(:created_event) { Event.first }
      let(:request)  { post :create, event: event_attrs }
      before { sign_in admin }

      it { expect(request).to redirect_to event_path(created_event) }

      it 'assigns organizer to event' do
        post :create, event: event_attrs
        expect(created_event.organizer).to eq admin
      end
    end
  end
end
