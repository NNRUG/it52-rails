# frozen_string_literal: true

require 'rails_helper'

describe EventDecorator do
  subject(:decorated_event) { event.decorate }

  describe '#rendered_description' do
    subject { decorated_event.rendered_description }

    let(:event) { build(:event, :with_markdown) }

    it { is_expected.to eq(%(<p>I&#39;m <strong>description</strong> with <em>markdown</em>.</p>\n)) }
  end

  describe '#human_time_distance' do
    subject { decorated_event.human_time_distance }

    context 'when today' do
      let(:event) { build(:event, started_at: Time.current) }

      it { is_expected.to eq 'сегодня' }
    end

    context 'when yesterday' do
      let(:event) { build(:event, started_at: 1.day.ago) }

      it { is_expected.to eq 'вчера' }
    end

    context 'when the day before yesterday' do
      let(:event) { build(:event, started_at: 2.days.ago) }

      it { is_expected.to eq 'позавчера' }
    end

    context 'when started 1 month ago' do
      let(:event) { build(:event, started_at: 1.month.ago) }

      it { is_expected.to eq 'около 1 месяца назад' }
    end

    context 'when started 5 months ago' do
      let(:event) { build(:event, started_at: 5.months.ago) }

      it { is_expected.to eq '5 месяцев назад' }
    end

    context 'when started 1 year ago' do
      let(:event) { build(:event, started_at: 1.year.ago) }

      it { is_expected.to eq 'около 1 года назад' }
    end

    context 'when tomorrow' do
      let(:event) { build(:event, started_at: 1.day.from_now) }

      it { is_expected.to eq 'завтра' }
    end

    context 'when the day after tomorrow' do
      let(:event) { build(:event, started_at: 2.days.from_now) }

      it { is_expected.to eq 'послезавтра' }
    end

    context 'when started in 1 month' do
      let(:event) { build(:event, started_at: 1.month.from_now) }

      it { is_expected.to eq 'через месяц' }
    end

    context 'when started in 2 months' do
      let(:event) { build(:event, started_at: 2.months.from_now) }

      it { is_expected.to eq 'через пару месяцев' }
    end

    context 'when started in 6 months' do
      let(:event) { build(:event, started_at: 6.months.from_now) }

      it { is_expected.to eq 'через 6 месяцев' }
    end

    context 'when started in 1 year' do
      let(:event) { build(:event, started_at: 1.year.from_now) }

      it { is_expected.to eq 'ещё около 1 года' }
    end
  end
end
