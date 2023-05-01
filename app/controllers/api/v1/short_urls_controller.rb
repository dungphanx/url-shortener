class Api::V1::ShortUrlsController < Api::V1::BaseController
  def encode
    url = current_user.urls.first_or_create!(original_url: params[:original_url])

    render json: { short_url: url.short_url }
  end

  def decode
    url = Url.find_by_short_url(params[:short_url])

    render json: { original_url: url&.original_url }
  end
end