# frozen_string_literal: true

describe ExternalUrlsRequestDecorator do
  subject(:decorator) { described_class.new(object) }

  let(:object) { build :external_urls_request, :with_fixed_dates }

  describe '#delivery_subject' do
    subject(:delivery_subject) { decorator.delivery_subject }

    let(:since) { decorator.start_time }
    let(:up_to) { decorator.end_time }

    it { is_expected.to eq "External urls in #{object.user.nickname}'s home line between #{since} and #{up_to}" }
  end

  describe '#start_time' do
    subject(:start_time) { decorator.start_time }

    it { is_expected.to eq '2020-01-01 12:30' }
  end

  describe '#end_time' do
    subject(:end_time) { decorator.end_time }

    it { is_expected.to eq '2020-01-04 11:33' }
  end

  describe '#created_at' do
    subject(:created_at) { decorator.created_at }

    it { is_expected.to eq '2020-01-10 22:55:33' }
  end

  describe '#updated_at' do
    subject(:updated_at) { decorator.updated_at }

    it { is_expected.to eq '2020-01-11 23:11:22' }
  end
end
