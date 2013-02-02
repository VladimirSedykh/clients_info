class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_curretn_group
  helper_method :current_group, :search_action?

  def set_curretn_group
    if !request.xhr?
      if session[:group].blank?
        session[:group] = "client"
      elsif params[:group].present?
        session[:group] = params[:group]
      elsif params[:controller] == "clients" && params[:action] == "search"
        session[:group] = "search"
      end
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

  def search_action?
    params[:last_action] == "search"
  end

  def main_page?
    params[:controller] == "pages" && params[:action] == "index"
  end

  WillPaginate.per_page = 25
end
