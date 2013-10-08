module RequestsHelper

  def sender_name(request)
    User.find(request.sender).name
  end
end
