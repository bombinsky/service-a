# frozen_string_literal: true

describe SessionsController do

  describe 'DELETE destroy' do
    it_behaves_like 'demanding authenticated user', :delete, :destroy

    context 'when user is authenticated' do
      before do
        authenticate(create(:user))
        allow(session).to receive(:delete)

        delete :destroy
      end

      it 'deletes user session' do
        expect(session).to have_received(:delete).with(:user_id)
      end

      it "redirects user to root path" do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET new' do
    before { get :new }

    it_behaves_like 'successful html response with template', :new
  end

  describe 'GET create' do
    before do
      request.env['omniauth.auth'] = auth_hash

      post :create
    end

    let(:auth_hash) do
      OmniAuth::AuthHash.new({ provider: 'twitter', uid: '123545',
        info: { nickname: 'nickname', email: 'nickname@email.com'},
        credentials: { token: 'token', secret: 'secret' }
      })
    end

    it "redirects user to root path" do
      expect(response).to redirect_to(root_path)
    end
  end
end
