require 'digest/sha1'
class SessionController < ApplicationController
  def create
    session[:username]= Digest::SHA1.hexdigest(params[:username])
    session[:password]= Digest::SHA1.hexdigest(params[:password])
    if admin?
      redirect_to :back, :notice => '登入成功!'
    else
      redirect_to :back, :notice => '登入失败!'
    end
  end

  def destroy
    reset_session
    redirect_to :back
  end
end