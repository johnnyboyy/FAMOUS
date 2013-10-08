class RequestsController < ApplicationController
  before_action :authenticate_user!


  def new
    @band = Band.find(params[:band_id])
    @request = Request.new
  end

  def show
    @requests = Request.where(reciever: current_user.id)
  end 


  def create
    @request = Request.new(request_params)
    send_message_to_band_members

    if @request.save
      redirect_to current_user, notice: "Request has been sent."
    else
      flash.now[:alert] = "We couldn't send the request."
      render 'new'
    end
  end

  def update
    @request = Request.find(params[:request_id])
    @band = Band.find(@request.band_id)

    if current_user.id == @request.reciever
      @band.users << User.find(@request.sender)
      Request.where(sender: @request.sender).where(band_id: @request.band_id).map(&:destroy)
    end

    if @band.save && @request.save
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
      params.require(:request).permit(:message)
    end

    def send_message_to_band_members
      Band.find(params[:band_id]).users.each do |mem|
        @request.request_type = 'member_request'
        @request.status = 'pending'
        @request.sender = current_user.id
        @request.reciever = mem.id
        @request.band_id = params[:band_id]
      end
    end

    def requester_name(request)
      User.find(request.sender).name
    end
end
