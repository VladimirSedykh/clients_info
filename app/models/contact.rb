class Contact < ActiveRecord::Base
  attr_accessible :name, :cellphone, :phone, :email, :icq, :skype
  belongs_to :client
end
