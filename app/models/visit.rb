class Visit < ApplicationRecord
  belongs_to :mini_url

  validates :ip_address, presence: true
end
