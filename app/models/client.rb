#!/bin/env ruby
# encoding: utf-8
class Client < ActiveRecord::Base
  attr_accessible :name, :description, :address, :activity, :role, :created_at, :updated_at, :state, :short_contacts
  has_many :contacts, :dependent => :destroy
  validates_presence_of :name
  validate :check_name

  GROUPS = { "client" => "Клиенты", "provider" => "Поставщики", "partner" => "Партнеры" }

  scope :by_group, lambda {|group| where(:role => group)}

  def contacts_for_update
    contact = contacts.first
    [contact.try(:cellphone), contact.try(:phone), contact.try(:email)].join(", ")
  end

  def update_short_contacts
    cellphones = contacts.map(&:cellphone).delete_if(&:blank?)
    phones = contacts.map(&:phone).delete_if(&:blank?)
    emails = contacts.map(&:email).delete_if(&:blank?)
    data = [cellphones.first, phones.first, emails.first].compact.join(", ")
    update_attributes(:short_contacts => data)
  end

  private

  def check_name
    if Client.where(:name => self.name, :role => self.role).count > 0
      errors[:base] << "Клиент с таким именем уже существует."
    end
  end
end
