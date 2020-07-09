# frozen_string_literal: true

describe ExternalUrl do
  it { is_expected.to validate_presence_of :url }
  it { is_expected.to validate_presence_of :page_title }
  it { is_expected.to belong_to :external_urls_request }
end
