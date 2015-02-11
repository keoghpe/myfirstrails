class BandsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :delete]

  def index
    @bands = Band.paginate(page: params[:page])
  end

  def show
    @band = Band.find(params[:id])
  end

  def new
    @band = Band.new
  end

  def create
    @band = current_user.bands.build(band_params)
    if @band.save
      flash[:success] = "Band created!"
      redirect_to @band
    else
      render 'new'
    end
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    @band = Band.find(params[:id])
    if @band.update_attributes(band_params)
      flash[:success] = "Band profile updated"
      redirect_to @band
    else
      render 'edit'
    end
  end

  private

    def band_params
      params.require(:band).permit(:name, :bio)
    end

    def correct_user
      @band = Band.find(params[:id])
      redirect_to(root_url) unless current_user.id == @band.user_id
    end
end
