class Contact < ActiveRecord::Base
  attr_accessible :name, :cellphone, :phone, :email, :icq, :skype
  belongs_to :client

  validate :check_attributes

  private

  def check_attributes
    attrs = self.attributes.delete_if{|k,v| k == "client_id" || v.blank? }
    errors[:base] << "Record is empty." if attrs.empty?
  end
end
