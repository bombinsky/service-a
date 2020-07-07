# frozen_string_literal: true

# Module needed to test controllers guarded by TokenAuth
module UserAuthHelper
  def authenticate(user)
    allow(controller).to receive(:current_user).and_return(user)
  end
end
