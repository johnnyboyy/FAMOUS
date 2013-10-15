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
    debugger
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
      Request.where(status: "pending").where(sender: @request.sender).where(band_id: @request.band_id).where(request_type: "member").map(&:destroy)
    end

    if @request.request_type == "booking" && @band.users.include?(current_user)
      Request.where(status: "pending").where(sender: @request.sender).where(band_id: @request.band_id).where(request_type: "booking").each do |req|
        req.status = "accepted"
        req.save
      end
    end

    if @band.save
      redirect_to band_path(@band), notice: "Request from #{requester_name(@request)} has been accepted!" 
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
      params.require(:request).permit(:message, :request_type, :band_id, :pay, :per, :showtime, :location)
    end

    def send_message_to_band_members
      Band.find(params[:band_id]).users.each do |mem|
        req = Request.new(request_params)
        req.status = 'pending'
        req.sender = current_user.id
        req.reciever = mem.id
        req.band_id = params[:band_id]
        if req.request_type == "booking"
          req.message = req.booking_message
        end
        req.save
      end
    end
end
