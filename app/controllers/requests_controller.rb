class RequestsController < ApplicationController
  before_action :authenticate_user!
  

  def new
    @band = Band.find(params[:band_id])
    @request = Request.new
    @request.request_type = params[:request_type]
    @request.band_id = params[:band_id]
  end

  def show
    @requests = Request.where(reciever: current_user.id)
  end 



  def create
    @band = Band.find(request_params[:band_id])
    @request = Request.new(request_params)
    # @band.users.first.requests.map(&:sender).include?(current_user.id)

    if send_message_to_band_members(@band)
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
      Request.where(status: "pending").where(sender: @request.sender).where(band_id: @request.band_id).where(request_type: "booking").where(showtime: @request.showtime).each do |req|
        req.status = "accepted"
        req.save
      end
    end

    if @band.save
      redirect_to band_path(@band), notice: "Request from #{@request.requester_name} has been accepted!" 
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
      params.require(:request).permit(:message, :request_type, :band_id, :pay, :per, :location)
    end

    def send_message_to_band_members(band)
      band.users.each do |mem|
        req = Request.new(request_params)
        req.showtime = DateTime.strptime(params[:request][:showtime], format='%m/%e/%Y')
        req.status = 'pending'
        req.sender = current_user.id
        req.reciever = mem.id
        if req.request_type == "booking"
          req.message = req.booking_message
        end
        if req.save == false
          return false
        end
      end
      return true
    end
      
end
