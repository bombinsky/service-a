# frozen_string_literal: true

describe ExternalUrlsRequestsController do
  describe 'GET show' do
    it_behaves_like 'demanding authenticated user', :get, :show, params: { id: 1 }

    context 'when user is authenticated' do
      before do
        authenticate(external_urls_request.user)

        get :show, params: { id: external_urls_request.id }
      end

      let(:external_urls_request) { create :external_urls_request }

      it_behaves_like 'successful html response with template', :show
    end
  end

  describe 'GET new' do
    context 'when user is authenticated' do
      before do
        authenticate(create(:user))
        get :new
      end

      it_behaves_like 'successful html response with template', :new
    end

    it_behaves_like 'demanding authenticated user', :get, :new
  end

  describe 'POST create' do
    it_behaves_like 'demanding authenticated user', :post, :create

    context 'when user is authenticated' do
      before do
        authenticate(user)
        allow_service_call(
          CreateExternalUrlsRequest,
          with: [user, hash_including(:email, :start_time, :end_time)],
          to_return: service_response
        )

        post :create, params: { external_urls_request: attributes }
      end

      let(:external_urls_request) { create :external_urls_request }
      let(:attributes) { attributes_for :external_urls_request }
      let(:user) { external_urls_request.user }

      context 'when CreateExternalUrlsRequest responds with invalid not persisted object' do
        let(:service_response) { ExternalUrlsRequest.new }

        it_behaves_like 'successful html response with template', :new
      end

      context 'when CreateExternalUrlsRequest responds with valid persisted object' do
        let(:service_response) { external_urls_request }

        it 'redirects user to action show' do
          expect(response).to redirect_to(external_urls_request_path(external_urls_request))
        end
      end
    end
  end
end
