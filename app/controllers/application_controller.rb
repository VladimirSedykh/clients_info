class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_curretn_group
  helper_method :current_group, :search_action?

  def set_curretn_group
    if session[:group].blank? && !search_action?
      session[:group] = "client"
    else
      session[:group] = params[:group]
    end
  end

  def current_group
    return nil if search_action?
    session[:group]
  end


  def detect_frame
    unless params[:main]
      render :layout => "history"
    end
  end

  def search_action?
    params[:last_action] == "search"
  end

  def main_page?
    params[:controller] == "pages" && params[:action] == "index"
  end

  WillPaginate.per_page = 25
end
