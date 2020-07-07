# frozen_string_literal: true

describe ExternalUrlsRequestDecorator do
  let(:object) { build :external_urls_request }
  subject(:decorator) { described_class.new(object) }

  it { is_expected.to respond_to :email }
  it { is_expected.to respond_to :user }
  it { is_expected.to respond_to :external_urls }

  describe '#delivery_subject' do
    let(:since) { object.start_time.strftime(described_class::TIME_FORMAT) }
    let(:up_to) { object.end_time.strftime(described_class::TIME_FORMAT) }

    subject(:delivery_subject) { decorator.delivery_subject }

    it { is_expected.to eq "External urls in #{ object.user.nickname }'s home line between #{ since } and #{ up_to }" }
  end

  describe '#start_time' do
    subject(:start_time) { decorator.start_time }

    it { is_expected.to eq object.start_time.strftime(described_class::TIME_FORMAT) }
  end

  describe '#end_time' do
    subject(:start_time) { decorator.end_time }

    it { is_expected.to eq object.end_time.strftime(described_class::TIME_FORMAT) }
  end

  describe '#created_at' do
    subject(:start_time) { decorator.created_at }

    it { is_expected.to eq object.created_at.strftime(described_class::TIMESTAMP_FORMAT) }
  end

  describe '#updated_at' do
    subject(:start_time) { decorator.updated_at }

    it { is_expected.to eq object.updated_at.strftime(described_class::TIMESTAMP_FORMAT) }
  end
end
