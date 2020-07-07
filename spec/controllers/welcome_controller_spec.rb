# frozen_string_literal: true

describe WelcomeController do
  describe 'GET index' do
    it_behaves_like 'demanding authenticated user', :get, :index

    context 'when user is authenticated' do
      before do
        authenticate(create(:user))

        get :index
      end

      it_behaves_like 'successful html response with template', 'index'
    end
  end
end
