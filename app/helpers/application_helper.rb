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

  def client_description
    name = content_tag(:span, @client.name)
    img = image_tag("edit.png", :class => "edit-client")
    state = "#{@client.state} обл" if @client.state
    desc = [@client.activity, state, @client.address]
    desc = desc.compact.delete_if(&:blank?).join(", ")
    if desc.present?
      name + content_tag(:span, " (#{desc}) ", :class => "frame-client-description") +  img
    else
      name + img
    end
  end

  def order_mark(field)
    if params[:field] == field
      if params[:direction] == "asc"
        "&#9660;"
      else
        "&#9650;"
      end
    else
      ""
    end
  end

  def order_direction(field)
    if params[:field] == field && params[:direction] == "asc"
      "desc"
    else
      "asc"
    end
  end

  def short_date(date)
    date.strftime("%d %b, %H:%M")
  end
end
