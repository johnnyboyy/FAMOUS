class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_band, only: [:new, :create]
  before_action :get_request, only: :update
  

  def new
    @request = Request.new
    @request.request_type = params[:request_type]
    @request.band_id = params[:band_id]
  end

  def show
    @requests = Request.where(reciever: current_user.id)
  end 



  def create
    @request = Request.new(request_params)
    # @band.users.first.requests.map(&:sender).include?(current_user.id)
    # if send_message_to_band_members(@band)
    if send_message_to_band(@band, @request)
      redirect_to current_user, notice: "Request has been sent."
    else
      flash.now[:alert] = "We couldn't send the request. Please try again."
      render 'new'
    end
  end



  def update
    @band = Band.find(@request.band_id)


    if @request.request_type == "member" && @band.users.include?(current_user)
      @band.users << User.find(@request.sender)

      ## TODO move to Model
      User.find(@request.sender).likes.each do |l|
        if @band.songs.map(&:id).include?(l.song_id)
          l.destroy
        end
      end
      ####




    @band.pending_member_requests_by_obj(@request).map(&:destroy)


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

    def get_request
      @request = Request.find(params[:request_id])
    end

    def get_band
      @band = Band.find(params[:band_id])
    end

    def request_params
      params.require(:request).permit(:message, :request_type, :band_id, :pay, :per, :location)
    end

    def send_message_to_band_members(band)
      band.users.each do |mem|
        req = Request.new(request_params)
        req.status = 'pending'
        req.sender = current_user.id
        req.reciever = mem.id
        if req.request_type == "booking"
          req.showtime = DateTime.strptime(params[:request][:showtime], format='%m/%e/%Y')
          req.message = req.booking_message
        end
        if req.save == false
          return false
        end
      end
      return true
    end

    def send_message_to_band(band, request)
      band.requests.build do |req|
        req.request_type = requst.request_type
        req.status = 'pending'
        req.sender = current_user.id
        req.reciever = band.id
        if req.request_type == "booking"
          req.showtime = DateTime.strptime(params[:request][:showtime], format='%m/%e/%Y')
          req.message = req.booking_message
        end
        if req.save == false
          return false
        end
      end
      return true
    end
      
end
