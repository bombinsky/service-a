# frozen_string_literal: true

describe ExternalUrlsRequest do
  subject(:object) { described_class.new }

  it { is_expected.to belong_to :user }
  it { is_expected.to have_many :external_urls }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :start_time }
  it { is_expected.to validate_presence_of :end_time }

  it { is_expected.not_to allow_value(object.end_time).for(:start_time) }
  it { is_expected.not_to allow_value(object.start_time).for(:end_time) }
  it { is_expected.to allow_value(object.end_time - 1.second).for(:start_time) }
  it { is_expected.to allow_value(object.start_time + 1.second).for(:end_time) }

  it { is_expected.not_to allow_value('email').for(:email) }
  it { is_expected.not_to allow_value('email@').for(:email) }
  it { is_expected.not_to allow_value('email@domain').for(:email) }

  it { is_expected.to allow_value('email@domain.com').for(:email) }

  describe '#after_initialize' do
    before { allow(Time).to receive(:current).and_return current_time }

    let(:current_time) { Time.current }

    it 'sets start_time to one day ago' do
      expect(object.start_time).to eq current_time - 1.day
    end

    it 'sets end_time to current time' do
      expect(object.end_time).to eq current_time
    end
  end
end
