class Url < ApplicationRecord
  SALT_NUM = 100_000_000
  
  belongs_to :user

  validates :original_url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])

  def short_url
    return nil if id.nil?

    (SALT_NUM + id).to_base62_encode
  end

  def self.find_by_short_url(short_url)
    return nil if short_url.nil?

    find_by(id: short_url.to_base62_decode - SALT_NUM)
  end
end
