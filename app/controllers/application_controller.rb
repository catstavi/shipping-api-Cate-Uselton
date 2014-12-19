class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def new_log
    Log.create(url: request.original_url, parameters: params.to_s, IP_add: request.remote_addr)
  end

  def add_log_response
    Log.last.update(response: response.body)
  end


end
