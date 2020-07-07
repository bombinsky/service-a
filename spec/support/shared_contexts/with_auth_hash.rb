# frozen_string_literal: true

shared_context 'with auth hash' do
  let(:auth_hash) do
    OmniAuth::AuthHash.new(
      provider: 'twitter',
      uid: '123545',
      info: { nickname: 'nickname', email: 'nickname@email.com' },
      credentials: { token: 'token', secret: 'secret' }
    )
  end
end
