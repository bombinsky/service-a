# frozen_string_literal: true

describe ExternalUrlsRequestsController do
  describe 'GET new' do
    context 'when user is not authenticated' do
      before { get :new }

      it_behaves_like 'demanding authenticated user'
    end

    context 'when user is authenticated' do
      before do
        authenticate(create(:user))

        get :new
      end

      it_behaves_like 'successful html response with template', 'new'
    end
  end

  describe 'GET show' do
    context 'when user is not authenticated' do
      before { get :show, params: { id: 1 } }

      it_behaves_like 'demanding authenticated user'
    end

    context 'when user is authenticated' do
      before do
        authenticate(external_urls_request.user)

        get :show, params: { id: external_urls_request.id }
      end

      let(:external_urls_request) { create :external_urls_request }

      it_behaves_like 'successful html response with template', 'show'
    end
  end

end
