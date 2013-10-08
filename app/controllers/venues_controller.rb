class VenuesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @venues = Venue.all
  end

  def show
    @venue = Venue.all
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)
    @venue.user_id = current_user.id

    if @venue.save
      redirect_to venues_path, notice: "#{@venue.name} was added"
    else
      render 'new'
    end
  end

  def edit
    @venue = Venue.find(params[:id])
  end

  def update
    respond_to do |format|
      if @venue.update(venue_params)
      format.html { redirect_to @venue, notice: 'The venue was successfully updated.' }
      #format.json { head :no_content }
      else
      format.html { render action: "edit" }
      #format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end 

  def destroy
    @venue = Venue.find(params[:id])
    @venue.destroy
    respond_to do |format|
      format.html { redirect_to current_user, notice: "You deleted your venue: #{@venue.name}" }
    end
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :address, :image)
  end

end

