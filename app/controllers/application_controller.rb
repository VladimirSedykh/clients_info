class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_group
  before_filter :set_curretn_group

  def set_curretn_group
    if session[:group].blank?
      session[:group] = "client"
    end
  end

  def current_group
    session[:group]
  end


  def detect_frame
    unless params[:main]
      render :layout => "history"
    end
  end

  WillPaginate.per_page = 2
end
