class Api::V1::ShortUrlsController < Api::V1::BaseController
  def encode
    url = current_user.urls.find_or_create_by(original_url: params.fetch(:original_url))

    render json: { short_url: base_url + url.short_url }
  end

  def decode
    short_url = params.fetch(:short_url)
    return render_400 if short_url.blank?

    url = Url.find_by_short_url(short_url.gsub(base_url, ''))
    return render_404 if url.nil?

    render json: { original_url: url.original_url }
  end

  private

  def base_url
    ENV["BASE_URL"] || "localhost:3000/"
  end
end