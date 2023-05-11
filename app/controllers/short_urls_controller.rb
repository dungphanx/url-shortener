class ShortUrlsController < ApplicationController
  def show
    short_url = params.fetch(:short_url)
    return render_400 if short_url.blank?

    url = Url.find_by_short_url(short_url.gsub(base_url, ''))
    return render_400 if url.nil?

    redirect_to url.original_url, { allow_other_host: true }
  end

  private

  def render_400
    render json: { error: 'Bad Request' }, status: 400
  end

  def base_url
    ENV["BASE_URL"] || "localhost:3000/"
  end
end