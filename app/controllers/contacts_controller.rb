class ContactsController < ApplicationController
  before_filter :find_client
  before_filter :find_contact, :only => [:show, :edit, :update, :destroy]
  layout "history"

  def edit
    detect_frame
  end

  def create
    @contact = @client.contacts.build(params[:contact])
    if @contact.save
      @client.update_short_contacts
      redirect_to client_path(@client)
    else
      render "new"
    end
  end

  def update
    if @contact.update_attributes(params[:contact])
      @client.update_short_contacts
      redirect_to client_path(@client)
    else
      render "edit"
    end
  end

  def destroy
    @contact.destroy
    @client.update_short_contacts
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
