describe TwitterGateway do
  describe '#home_timeline' do
    subject(:home_timeline) { TwitterGateway.new.home_timeline(user, options)}

    let(:user) { build :user }
    let(:options) { { opt1: 'opt1' } }
    let(:tweets) { build_list(:tweet, 2) }

    let(:twitter_client) { instance_double(Twitter::REST::Client) }
    let(:config) { double }

    before do
      stub_const('ENV', 'TWITTER_CONSUMER_KEY' => 'consumer_key', 'TWITTER_CONSUMER_SECRET' => 'consumer_secret')
    end

    before do
      allow(Twitter::REST::Client).to receive(:new).and_yield(config).and_return(twitter_client)
      allow(config).to receive(:consumer_key=)
      allow(config).to receive(:consumer_secret=)
      allow(config).to receive(:access_token=)
      allow(config).to receive(:access_token_secret=)

      allow(twitter_client).to receive(:home_timeline).and_return tweets
    end

    it { is_expected.to eq tweets }

    it 'delegates home_timeline to twitter_client' do
      home_timeline

      expect(twitter_client).to have_received(:home_timeline).with(options)
    end

    it "creates twitter client correctly" do
      home_timeline

      expect(config).to have_received(:consumer_key=).with('consumer_key')
      expect(config).to have_received(:consumer_secret=).with('consumer_secret')
      expect(config).to have_received(:access_token=).with(user.token)
      expect(config).to have_received(:access_token_secret=).with(user.secret)
    end
  end
end