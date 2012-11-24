#!/bin/env ruby
# encoding: utf-8
module ApplicationHelper
  def current_group_name
    Client::GROUPS[current_group] || ""
  end
end
