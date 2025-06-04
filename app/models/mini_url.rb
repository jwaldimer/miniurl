class MiniUrl < ApplicationRecord
  has_many :visits, dependent: :destroy

  VALID_TOKEN_REGEX = /\A[a-zA-Z0-9\-_]+\z/
  RESERVED_ALIAS = %w[api admin login logout users new]
  CREATE_PARAMS = %i[original_url alias description]

  validates :original_url, presence: true, format: URI::DEFAULT_PARSER.make_regexp
  validates :alias, presence: true, uniqueness: true,
                    format: { with: VALID_TOKEN_REGEX },
                    length: { maximum: 50 }
  validates :creator_id, presence: true
  validate :token_not_reserved

  private

  def token_not_reserved
    return unless RESERVED_ALIAS.include?(self.alias&.downcase)
    errors.add(:alias, I18n.t("mini_url.errors.alias_reserved"))
  end
end
