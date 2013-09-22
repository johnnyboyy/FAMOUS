class BandsController < ApplicationController
	  def index
	  	@bands = Band.all
	
	  end
	
	  def show
	  	@band = Band.find(params[:id])
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
	  	@band = Band.find(params[:id])
	  end
	
	  def create
	  	@band = Band.new(band_params)
	  	@user = current_user
	
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
	  	@band = Band.find(params[:id])
	
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
	  	@band = Band.find(params[:id])
	  	@band.users << current_user
	  	redirect_to @band
	  end

	  def leave
	  	@band = Band.find(params[:id])
	  	@band.users.delete(current_user)
	  	redirect_to @band
	  end
	
	  def destroy
	  	@band = Band.find(params[:id])
	  	@band.destroy
	
	    respond_to do |format|
	      format.html { redirect_to bands_url }
	      format.json { head :no_content }
	    end
	  end
	
	  def band_params
	  	params.require(:band).permit(:name)
	  end
	  

end
