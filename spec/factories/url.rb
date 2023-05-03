FactoryBot.define do
  factory :url do
    original_url { 'http://example.com' }
    user
  end
end