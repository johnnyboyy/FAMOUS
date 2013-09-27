class BandsController < ApplicationController
	before_action :get_band, only: [:show, :edit, :update, :join, :leave, :destroy]

  def index
  	@bands = Band.all

  end

  def show
		@members = @band.users
		@songs = @band.songs.order("fame DESC")

  end

  def new
  	@band = Band.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bands }
    end
  end

  def edit
  end

  def create
  	@band = Band.new(band_params)
  	@band.users << current_user

    respond_to do |format|
      if @band.save
        format.html { redirect_to @band, notice: 'band was successfully created.' }
        format.json { render json: @band, status: :created, location: @band }
      else
        format.html { render action: "new" }
        format.json { render json: @band.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @band.update(band_params)
        format.html { redirect_to @band, notice: 'band was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @band.errors, status: :unprocessable_entity }
      end
    end
  end

  def join
  	@band.users << current_user
  	redirect_to @band
  end

  def leave
  	@band.users.delete(current_user)
  	redirect_to @band
  end

  def destroy
  	@band.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end


  private

	  def band_params
	  	params.require(:band).permit(:name)
	  end
	  
	  def get_band
	  	@band = Band.find(params[:id])
	  end

end
