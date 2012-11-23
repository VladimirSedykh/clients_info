class Client < ActiveRecord::Base
  attr_accessible :name, :description, :address, :activity, :role, :created_at, :updated_at, :state, :short_contacts
  has_many :contacts
  validates_presence_of :name

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
end
