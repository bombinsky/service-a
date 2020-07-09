class ExternalUrl < ApplicationRecord
  belongs_to :external_urls_request

  validates :url, presence: true
  validates :page_title, presence: true
end
