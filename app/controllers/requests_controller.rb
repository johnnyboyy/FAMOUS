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
    request = Request.new(request_params)
    Band.find(params[:band_id]).users.each do |mem|
      request.request_type = 'member_request'
      request.status = 'pending'
      request.sender = current_user.id
      request.reciever = mem.id
      request.band_id = params[:band_id]
    end

    if request.save
      redirect_to current_user, notice: "Request has been sent."
    else
      flash.now[:alert] = "We couldn't send the request."
      render 'new'
    end
  end

  def update
    request = Request.find(params[:request_id])
    if current_user == request.reciever && params[:status] == 'accepted'
      Band.find(request.band_id).users << current_user
    end
  end


  def destroy
    Request.find(params[:request_id]).status = 'rejected'
  end


  private

  def request_params
    params.require(:request).permit(:message)
  end
end
