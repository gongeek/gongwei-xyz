module ApplicationHelper
  def admin?
    session[:username]=='3e6a7ad20c4dda809cfc6a6ced3cac661fd00ef7'&&session[:password]=='6cc4e3728e03fa31db11aa681395a402436a69d9'
  end

  def about?
    request.fullpath.include?('about')
  end

  def share?
    request.fullpath.include?('share')
  end

end
