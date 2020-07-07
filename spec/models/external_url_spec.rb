# frozen_string_literal: true

describe ExternalUrl do
  it { is_expected.to validate_presence_of :value }
  it { is_expected.to belong_to :external_urls_request }
end
