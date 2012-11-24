#!/bin/env ruby
# encoding: utf-8
class Contact < ActiveRecord::Base
  attr_accessible :name, :cellphone, :phone, :email, :icq, :skype
  belongs_to :client

  validate :check_attributes

  private

  def check_attributes
    attrs = self.attributes.delete_if{|k,v| %w(id client_id created_at updated_at).include?(k) || v.blank? }
    errors[:base] << "Ни одно поле не заполнено." if attrs.empty?
  end
end
