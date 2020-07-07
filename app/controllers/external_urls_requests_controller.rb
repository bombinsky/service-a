class ExternalUrlsRequestsController < ApplicationController
  before_action :authenticate_user

  def new
    @external_urls_request = ExternalUrlsRequest.new
  end

  def show
    @external_urls_request = current_user.external_urls_requests.find(params[:id]).decorate
  end

  def create
    if external_urls_request.persisted?
      redirect_to external_urls_request_path(external_urls_request)
    else
      render :new
    end
  end

  private

  def external_urls_request
    @external_urls_request ||= CreateExternalUrlsRequest.new(current_user, external_urls_request_attributes).call
  end

  def external_urls_request_attributes
    params.require(:external_urls_request).permit(:email, :start_time, :end_time)
  end
end
