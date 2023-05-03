require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:original_url) }
    it { is_expected.to allow_value('http://example.com').for(:original_url) }
    it { is_expected.to allow_value('https://example.com').for(:original_url) }
    it { is_expected.to_not allow_value('example.com').for(:original_url) }
  end

  describe '#short_url' do
    it 'returns nil if id is nil' do
      url = Url.new(id: nil)

      expect(url.short_url).to be_nil
    end

    it 'returns a short URL string' do
      url = Url.new(id: 123)

      expect(url.short_url).to eq('h7G')
    end
  end

  describe '.find_by_short_url' do
    it 'returns nil if short_url is nil' do
      url = Url.find_by_short_url(nil)

      expect(url).to be_nil
    end

    it 'returns the Url object with the matching short URL' do
      url = Url.create(original_url: 'http://example.com')
      short_url = url.short_url

      expect(Url.find_by_short_url(short_url)).to eq(url)
    end
  end
end