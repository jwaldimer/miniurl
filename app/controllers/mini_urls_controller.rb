class MiniUrlsController < ApplicationController
  before_action :set_creator_id

  def new
    @mini_url = MiniUrl.new
    @urls = MiniUrl.where(creator_id: @creator_id).order(created_at: :desc)
  end

  def create
    @mini_url = MiniUrl.new(mini_url_params)
    @mini_url.creator_id = @creator_id

    if @mini_url.save
      redirect_to mini_url_path(@mini_url), notice: "URL creada exitosamente"
    else
      @urls = MiniUrl.where(creator_id: @creator_id)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @mini_url = MiniUrl.find(params[:id])
  end

  def info
    @mini_url = MiniUrl.includes(:visits).find_by!(alias: params[:token])
  end

  private

  def mini_url_params
    params.require(:mini_url).permit(MiniUrl::CREATE_PARAMS)
  end

  def set_creator_id
    cookies.permanent.signed[:creator_id] ||= SecureRandom.uuid

    @creator_id = cookies.signed[:creator_id]
  end
end
