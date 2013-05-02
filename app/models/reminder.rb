#!/bin/env ruby
# encoding: utf-8
class Reminder < ActiveRecord::Base
  attr_accessible :description, :scheduled_time, :closed, :showed
  validates :scheduled_time, :presence => {:message => "не заполнено."}
  belongs_to :client

  scope :not_closed, where("(closed = false OR closed IS NULL)")
  scope :not_showed, where("(showed = false OR showed IS NULL)")
  default_scope order("closed, scheduled_time, created_at")

  def full_info
    "Дата: #{scheduled_time.strftime('%d %b, %H:%M')} \n" + 
    "Клиент: #{client.name} \n" +
    "Описание: #{description}"
  end
end
