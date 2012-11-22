class Client < ActiveRecord::Base
  attr_accessible :name, :description, :created_at, :updated_at
end
