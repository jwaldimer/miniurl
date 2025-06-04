class RedirectsController < ApplicationController
  def show
    mini_url = MiniUrl.find_by!(alias: params[:token])
    mini_url.visits.create!(ip_address: request.remote_ip, browser: request.browser)
    redirect_to mini_url.original_url, allow_other_host: true
  end
end
