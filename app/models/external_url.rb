class ExternalUrl < ApplicationRecord
  belongs_to :external_urls_request

  validates :value, presence: true
end
