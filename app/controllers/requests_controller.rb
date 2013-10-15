class RequestsController < ApplicationController
  before_action :authenticate_user!


  def new
    @band = Band.find(params[:band_id])
    @request = Request.new
    @request.request_type = params[:request_type]
  end

  def show
    @requests = Request.where(reciever: current_user.id)
  end 



  def create
    @request = Request.new(request_params)
    @band = Band.find(params[:band_id])
    send_message_to_band_members

    if @band.users.first.requests.map(&:sender).include?(current_user.id)
      redirect_to current_user, notice: "Request has been sent."
    else
      flash.now[:alert] = "We couldn't send the request. Please try again."
      render 'new'
    end
  end



  def update
    @request = Request.find(params[:request_id])
    @band = Band.find(@request.band_id)


    if @request.request_type == "member" && @band.users.include?(current_user)
      @band.users << User.find(@request.sender)
      Request.where(sender: @request.sender).where(band_id: @request.band_id).map(&:destroy)
    end

    if @band.save
      redirect_to band_path(@band), notice: "#{requester_name(@request)} has joined the band!" 
    else
      flash.now[:alert] = "We couldn't add #{requester_name(@request)}."
      render band_path(@band)
    end

  end




  def destroy
    Request.find(params[:request_id]).status = 'rejected'
  end








  private

    def request_params
      params.require(:request).permit(:message, :request_type, :band_id)
    end

    def booking_params
      params.require(:request).permit(:pay, :per, "showtime(2i)", "showtime(3i)", "showtime(4i)", :location)
    end

    def send_message_to_band_members
      Band.find(params[:band_id]).users.each do |mem|
        req = Request.new(request_params)
        req.status = 'pending'
        req.sender = current_user.id
        req.reciever = mem.id
        req.band_id = params[:band_id]
        if req.request_type == "booking"
          req.message = booking_message(req, booking_params)
        end
        req.save
      end
    end

    def formatted_time(month, day, hour)
      return "#{month}/#{day}/#{Time.now.year} at #{hour}"
    end

    def requester_name(request)
      User.find(request.sender).name
    end

    def booking_message(request, other_params)
      date = formatted_time(other_params["showtime(2i)"], other_params["showtime(3i)"], other_params["showtime(4i)"],)
      return "#{requester_name(request)} is willing to pay $#{other_params[:pay]}
       for #{other_params[:per]} for you to play a show
       at #{other_params[:location]}, on #{date}."
    end
end
