class ContactsController < ApplicationController
  before_filter :find_client
  before_filter :find_contact, :only => [:show, :new, :edit, :update, :destroy]

  def create
    @contact = @client.contacts.build(params[:contact])
    if @contact.save
      redirect_to client_path(@client)
    else
      render "new"
    end
  end

  def update
    if @contact.update_attributes(params[:contact])
      redirect_to client_path(@client)
    else
      render "edit"
    end
  end

  def destroy
    @contact.destroy
    redirect_to client_path(@client)
  end

  private

  def find_client
    @client = Client.find(params[:client_id])
  end

  def find_contact
    @contact = Contact.find(params[:id])
  end
end