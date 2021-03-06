# frozen_string_literal: true

shared_examples 'demanding authenticated user' do |method, action, options = {}|
  context 'when user is not authenticated' do
    before { public_send(method, action, options) }

    it 'redirects user to session new' do
      expect(response).to redirect_to(new_session_path)
    end

    it 'responds with content type text/html; charset=utf-8' do
      expect(response.content_type).to eq 'text/html; charset=utf-8'
    end
  end
end
