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

  WillPaginate.per_page = 1
end
