# frozen_string_literal: true

shared_context 'with tweet having two urls' do |first_final_redirect_url, last_final_redirect_url|
  let(:tweets) { [build(:tweet, created_at: external_urls_request.start_time + 1.second)] }
  let(:external_urls_request) { create :external_urls_request }
  let(:urls) { tweets.first.full_text.scan(described_class::URL_REGEXP) }

  let(:mechanize) { double }

  before do
    allow(Mechanize).to receive(:new).and_return mechanize
    allow(mechanize).to receive(:get).with(first_final_redirect_url).and_return OpenStruct.new(title: 'First url')
    allow(mechanize).to receive(:get).with(last_final_redirect_url).and_return OpenStruct.new(title: 'Last url')

    allow(FinalRedirectUrl).to receive(:final_redirect_url).with(urls.first).and_return(first_final_redirect_url)
    allow(FinalRedirectUrl).to receive(:final_redirect_url).with(urls.last).and_return(last_final_redirect_url)
  end
end
