# frozen_string_literal: true

describe User do
  it { is_expected.to have_many :external_urls_requests }
  it { is_expected.to validate_presence_of :nickname }
  it { is_expected.to validate_presence_of :secret }
  it { is_expected.to validate_presence_of :token }

  describe '.find_or_create_with_twitter_auth_hash' do
    subject(:find_or_create_with_twitter_auth_hash) do
      described_class.find_or_create_with_twitter_auth_hash(auth_hash)
    end

    let(:auth_hash) do
      OmniAuth::AuthHash.new(
        provider: 'twitter',
        uid: '123545',
        info: { nickname: 'nickname', email: 'nickname@email.com' },
        credentials: { token: 'token', secret: 'secret' }
      )
    end

    context 'when user does not exist' do
      it { is_expected.to be_an described_class }

      it 'creates user' do
        expect { find_or_create_with_twitter_auth_hash }.to change(described_class, :count).by(1)
      end
    end

    context 'when user exists' do
      before { find_or_create_with_twitter_auth_hash }

      it { is_expected.to be_an described_class }

      it 'does not create user' do
        expect { find_or_create_with_twitter_auth_hash }.not_to change(described_class, :count)
      end
    end
  end
end
