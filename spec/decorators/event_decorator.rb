require 'rails_helper'

describe EventDecorator do
  describe '#rendered_description' do
    let(:event) { FactoryBot.create(:event, :with_markdown).decorate }

    it { expect(event.rendered_description).to eq %(<p>I&#39;m <strong>description</strong> with <em>markdown</em>.</p>\n) }
  end
end
