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
    #before_action get_request
    @band = Band.find(@request.band_id)
    
    if current_user.is_member_of?(@band)
      @request.handle_request_for(@band)
    end

    if @request.save
      redirect_to band_path(@band), notice: "Request from #{@request.requester_name} has been accepted!" 
    else
      flash.now[:alert] = "We couldn't add #{@request.requester_name}."
      redirect_to band_path(@band)
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
        request.status = 'pending'
        request.sender = current_user.id
        request.reciever = band.id
        if request.request_type == "booking"
          request.showtime = DateTime.strptime(params[:request][:showtime], format='%m/%e/%Y')
          request.message = request.booking_message
        end
      if request.save == false
        return false
      else
        return true
      end
    end
      
end
