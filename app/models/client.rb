#!/bin/env ruby
# encoding: utf-8
class Client < ActiveRecord::Base
  attr_accessible :name, :description, :address, :activity, :role, :created_at, :updated_at, :state, :short_contacts
  has_many :contacts, :dependent => :destroy
  validates_presence_of :name
  validate :check_name

  GROUPS = { "client" => "Клиенты", "provider" => "Поставщики", "partner" => "Партнеры" }
  default_scope :order => 'created_at DESC'
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

  def self.search(params, group)
    clients =
      if params[:client].present?
        Client.by_group(group).where(Client.search_params(params, :client))
      else
        Client.by_group(group)
      end

    if params[:contact].present?
      clients = clients.joins(:contacts).where(Client.search_params(params, :contact))
    end
    return clients
  end

  private

  def self.search_params(params, param)
    search_params = params[param].delete_if{|k,v| v.blank?}
    conditions = []
    search_params.each do |key, value|
      if param == :client
        conditions << (key + " like \"%" + value + "%\"")
      elsif param == :contact
        if key == "phone"
          conditions << (" (contacts.phone like \"%" + value + "%\" OR contacts.cellphone like \"%" + value + "%\") ")
        else
          conditions << ("contacts." + key + " like \"%" + value + "%\"")
        end
      end
    end
    return conditions.join(" AND ")
  end

  def check_name
    if self.new_record? && Client.where(:name => self.name, :role => self.role).count > 0
      errors[:base] << "#{self.name} в этой группе уже существует."
    end
  end
end
