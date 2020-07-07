# frozen_string_literal: true

shared_context 'tweet with two urls' do |final_url_1, final_url_2|
  let(:tweets) { [build(:tweet, created_at: external_urls_request.start_time + 1.second)] }
  let(:external_urls_request) { create :external_urls_request }

  before do
    allow(FinalRedirectUrl).to receive(:final_redirect_url).with(urls.first).and_return(final_url_1)
    allow(FinalRedirectUrl).to receive(:final_redirect_url).with(urls.last).and_return(final_url_2)
  end
end
