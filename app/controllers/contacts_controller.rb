class ContactsController < ApplicationController
  def create
    client = Client.find(params[:client_id])
    client.contacts.create(params[:contact])
    redirect_to client_path(client)
  end
end
