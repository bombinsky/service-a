# frozen_string_literal: true

describe ProcessExternalUrlsRequest do
  subject(:service_call) { service.call }

  let(:service) { described_class.new(external_urls_request) }
  let(:external_urls_request) { create :external_urls_request }
  let(:user) { external_urls_request.user }
  let(:twitter_gateway) { instance_double(TwitterGateway) }
  let(:publisher) { instance_double(Publish) }
  let(:event_payload) { { request_id: external_urls_request.id }.to_json }
  let(:tweets) { [build(:tweet, :before_request_range)] }
  let(:urls) { tweets.first.full_text.scan(described_class::URL_REGEXP) }
  let(:page1_options) { { exclude_replies: true, trim_user: true, include_rts: false, tweet_mode: :extended, count: 200 } }
  let(:page2_options) { page1_options.merge(max_id: tweets.first.id.pred) }

  shared_examples 'processed external urls request' do
    it { is_expected.to be_truthy }

    it 'publishes event in external_urls_delivery_requests queue' do
      service_call

      expect(Publish).to have_received(:new).with('external_urls_delivery_requests', event_payload)
    end
  end

  context 'when twitter limits api requests with error' do
    before do
      allow(TwitterGateway).to receive(:new).and_return(twitter_gateway)
      allow(twitter_error).to receive(:rate_limit).and_return(OpenStruct.new(reset_in: 1))
      allow_service_call(Publish, with: ['external_urls_delivery_requests', event_payload])
      allow(service).to receive(:sleep)
    end

    let(:twitter_error) { Twitter::Error::TooManyRequests.new }

    it 'does not raise error because it sleeps until twitter api reset in time then retry' do
      call_count = 0
      allow(twitter_gateway).to receive(:home_timeline) do
        call_count += 1
        case call_count
          when 1
            raise twitter_error
          when 2
            tweets
          when 3
            []
        end
      end

      expect { service_call }.not_to raise_error

      expect(service).to have_received(:sleep).with(2)
    end
  end

  context 'when twitter does not limit api requests' do
    before do
      allow(TwitterGateway).to receive(:new).and_return(twitter_gateway)
      allow(twitter_gateway).to receive(:home_timeline).with(user, page1_options).and_return(tweets)
      allow(twitter_gateway).to receive(:home_timeline).with(user, page2_options).and_return([])
      allow_service_call(Publish, with: ['external_urls_delivery_requests', event_payload])
    end

    context 'when there is no tweets in request time range' do
      it_behaves_like 'processed external urls request'

      it 'does not crates external urls' do
        expect { service_call }.not_to change(ExternalUrl, :count)
      end
    end

    context 'when there are tweets but all internal' do
      before do
        tweets.first.created_at = external_urls_request.start_time + 1.second
        allow(FinalRedirectUrl).to receive(:final_redirect_url).with(urls.first).and_return('https://twitter.com/54rw')
        allow(FinalRedirectUrl).to receive(:final_redirect_url).with(urls.last).and_return('https://twitter.com/some_url')
      end

      it_behaves_like 'processed external urls request'

      it 'does not create external urls' do
        expect { service_call }.not_to change(ExternalUrl, :count)
      end
    end

    context 'when there are tweets and one is external' do
      before do
        tweets.first.created_at = external_urls_request.start_time + 1.second
        allow(FinalRedirectUrl).to receive(:final_redirect_url).with(urls.first).and_return('https://twitter.com/54rw')
        allow(FinalRedirectUrl).to receive(:final_redirect_url).with(urls.last).and_return('https://youtube.com/some_url')
      end

      it_behaves_like 'processed external urls request'

      it 'creates external url' do
        expect { service_call }.to change(ExternalUrl, :count).by(1)
      end
    end
  end
end
