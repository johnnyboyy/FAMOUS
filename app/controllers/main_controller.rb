class MainController < ApplicationController

	def index
    @topsong = Song.joins(:likes).where("likes.created_at > ?", 1.day.ago).order("songs.fame DESC").first  || Song.order("fame DESC").first
    @topsongoftheweek = Song.joins(:likes).where("likes.created_at > ?", 7.day.ago).order("songs.fame DESC").first  || Song.order("fame DESC").first

    if Genre.count < 7
      @top_seven_count = Genre.count
    else
      @top_seven_count = 7
    end

    @genres = Genre.all.order('count DESC').limit(7)
    @page_options = 'main/mainOptions'

    if params[:genre]
      @songs = Genre.find(params[:genre][:sort_by]).songs.order("fame DESC").page params[:page]
      @bands = Genre.find(params[:genre][:sort_by]).bands.order("fame DESC")
    else
      @songs = Song.all.order("fame DESC").page params[:page]
      @bands = Band.all.order("fame DESC")
    end
    
  end

  def search 
    bands = Band.where('name ILIKE ?', "%#{params[:term]}%")
    render json: bands.map{ |band| {value: band.name} } 
  end
end