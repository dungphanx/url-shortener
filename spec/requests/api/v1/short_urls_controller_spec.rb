require "rails_helper"

RSpec.describe "/api/v1/short_urls" do
  include_context "with authenticate user"

  describe "POST /api/v1/encode" do
    let(:original_url) { "http://example.com" }
    let(:params) do
      {
        original_url: original_url
      }
    end

    before do
      post "/api/v1/encode", params: params, headers: headers
    end

    context 'when invalid params' do
      context 'when original_url is nil' do
        let(:original_url) { nil }

        it 'returns the expected response' do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)).to eq({"error_message" => ["Original url can't be blank", "Original url is invalid"]})
        end
      end

      context 'when original_url is not a valid URL' do
        let(:original_url) { "example.com" }

        it 'returns the expected response' do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)).to eq({"error_message" => ["Original url is invalid"]})
        end
      end
    end

    context 'when valid params' do
      it 'returns the expected response' do
        expect(response).to have_http_status(:ok)
        base_url = ENV["BASE_URL"] || "localhost:3000/"
        short_url = Base62.encode(Url::SALT_NUM + Url.first.id)

        expect(JSON.parse(response.body)).to eq({"short_url" => [base_url, short_url].join('')})
      end
    end
  end

  describe "POST /api/v1/decode" do
    let(:short_url) { "http://example.com" }
    let(:params) do
      {
        short_url: short_url
      }
    end

    before do
      post "/api/v1/decode", params: params, headers: headers
    end

    context 'when invalid params' do
      context 'when short_url is nil' do
        let(:short_url) { nil }

        it 'returns the expected response' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'when record not found' do
        let(:short_url) { "example" }

        it 'returns the expected response' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'when valid params' do
      let!(:url) { create(:url, user: user) }
      let(:short_url) { url.short_url }

      it 'returns the expected response' do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({"original_url" => url.original_url})
      end
    end
  end
end