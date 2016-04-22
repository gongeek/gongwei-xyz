require 'digest/sha1'
class SessionController < ApplicationController
  def create
    session[:username]= Digest::SHA1.hexdigest(params[:username])
    session[:password]= Digest::SHA1.hexdigest(params[:password])
    redirect_to :back
  end

  def destroy
    reset_session
    redirect_to :back
  end
end