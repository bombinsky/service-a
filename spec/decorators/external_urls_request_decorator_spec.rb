# frozen_string_literal: true

describe ExternalUrlsRequestDecorator do
  let(:object) { build :external_urls_request }
  let(:decorator) { described_class.new(object) }

  describe '#delivery_subject' do
    let(:since) { object.start_time.strftime(described_class::TIME_FORMAT) }
    let(:up_to) { object.end_time.strftime(described_class::TIME_FORMAT) }

    subject(:delivery_subject) { decorator.delivery_subject }

    it { is_expected.to eq "External urls in #{ object.user.nickname }'s home line between #{ since } and #{ up_to }" }
  end
end
