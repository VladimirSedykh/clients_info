#!/bin/env ruby
# encoding: utf-8
module ApplicationHelper
  def current_group_name
    Client::GROUPS[current_group] || ""
  end

  def search_value(params, param, key)
    session["params"].try(:[], param).try(:[], key)
  end

  def frame
    params[:frame] ? "iframe-link" : ""
  end
end
